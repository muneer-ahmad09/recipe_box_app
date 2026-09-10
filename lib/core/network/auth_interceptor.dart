import 'package:dio/dio.dart';
import 'package:recipe_box_app/core/storage/token_storage.dart';
import 'package:recipe_box_app/models/token_pair.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final Dio refreshDio;

  AuthInterceptor(this.tokenStorage, this.refreshDio);

  late Dio dio;

  void setDio(Dio dio) {
    this.dio = dio;
  }

  Future<TokenPair>? refreshFuture;

  Future<TokenPair> _refreshToken() async {
    final tokenPair = await tokenStorage.getTokenPair();
    if (tokenPair == null) {
      throw Exception('No token pair found');
    }

    final response = await refreshDio.post(
      '/auth/refresh',
      data: {'refresh_token': tokenPair.refreshToken},
    );
    final newToken = TokenPair.fromJson(response.data);
    await tokenStorage.saveTokenPair(newToken);
    return newToken;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final publicPath =
        options.path == '/auth/login' || options.path == '/auth/register';

    if (!publicPath) {
      final tokenPair = await tokenStorage.getTokenPair();
      if (tokenPair == null) {
        handler.next(options);
        return;
      }
      options.headers['Authorization'] = 'Bearer ${tokenPair.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    bool startedRefresh = false;
    if (err.response?.statusCode == 401) {
      //will add logic later
      final hasRetried = err.requestOptions.extra['auth_retry'] == true;
      if (hasRetried) {
        handler.next(err);
        return;
      }
      try {
        // refreshFuture ??= _refreshToken(); //this means if refreshFuture == null then refreshFuture = _refreshToken()
        if(refreshFuture == null){
          refreshFuture = _refreshToken();
          startedRefresh = true;
        }
        await refreshFuture;
        err.requestOptions.extra['auth_retry'] = true;
      } catch (_) {
        if(startedRefresh) {
          await tokenStorage.deleteTokenPair();
        }
        handler.next(err);
        return;
      } finally {
        if(startedRefresh){
          refreshFuture = null;
        }
      }

      final retryResponse = await dio.fetch(err.requestOptions);
      handler.resolve(retryResponse);

    } else {
      handler.next(err);
    }
  }
}

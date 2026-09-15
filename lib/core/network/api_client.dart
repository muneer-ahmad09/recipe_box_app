import 'package:dio/dio.dart';
import 'package:recipe_box_app/core/network/auth_interceptor.dart';
import 'package:recipe_box_app/models/favorite_api_model.dart';
import 'package:recipe_box_app/models/token_pair.dart';

import '../../models/page.dart';
import '../../models/recipe_card.dart';
import '../../models/user.dart';
import 'api_config.dart';
import 'api_exception.dart';

class ApiClient {
  final AuthInterceptor authInterceptor;

  ApiClient(this.authInterceptor) {
    authInterceptor.setDio(dio);
    dio.interceptors.add(authInterceptor);
  }

  final Dio dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  Future<Response> _request(
    String path,
    String method, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String? contentType,
  }) async {
    try {
      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, contentType: contentType),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  //Exception
  ApiException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return ApiException('Connection timed out. Please try again.');

      case DioExceptionType.connectionError:
        return ApiException(
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.badCertificate:
        return ApiException(
          'Could not establish a secure connection. Please try again.',
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 400:
            return ApiException('Invalid request.');

          case 401:
            return ApiException('You are not authorized.');

          case 403:
            return ApiException(
              'You do not have permission to perform this action.',
            );

          case 404:
            return ApiException('The requested resource was not found.');

          case 500:
          case 502:
          case 503:
          case 504:
            return ApiException('Server error. Please try again later.');

          default:
            return ApiException('Request failed. Please try again.');
        }

      case DioExceptionType.cancel:
        return ApiException('Request was canceled.');

      case DioExceptionType.unknown:
        return ApiException('Something went wrong. Please try again.');
    }
  }

  //Auth Apis

  // Future<TokenPair> login(String email, String password) async {
  //   final response = await dio.post(
  //     '/auth/login',
  //     data: {'username': email, 'password': password},
  //     options: Options(contentType: Headers.formUrlEncodedContentType),
  //   );
  //   return TokenPair.fromJson(response.data);
  // }

  Future<TokenPair> login(String email, String password) async {
    final response = await _request(
      '/auth/login',
      'POST',
      data: {'username': email, 'password': password},
      contentType: Headers.formUrlEncodedContentType,
    );

    return TokenPair.fromJson(response.data);
  }

  Future<User> getCurrentUser() async {
    final response = await _request('/auth/me', 'GET');
    return User.fromJson(response.data);
  }

  // Future<TokenPair> register(
  //   String email,
  //   String password,
  //   String fullName,
  // ) async {
  //   final response = await dio.post(
  //     '/auth/register',
  //     data: {'email': email, 'password': password, 'full_name': fullName},
  //     options: Options(contentType: Headers.jsonContentType),
  //   );
  //   return TokenPair.fromJson(response.data);
  // }

  Future<TokenPair> register(
    String email,
    String password,
    String fullName,
  ) async {
    final response = await _request(
      '/auth/register',
      'POST',
      data: {'email': email, 'password': password, 'full_name': fullName},
      contentType: Headers.jsonContentType,
    );

    return TokenPair.fromJson(response.data);
  }

  // Future<void> logout(String refreshToken) async {
  //   await dio.post(
  //     '/auth/logout',
  //     data: {'refresh_token': refreshToken},
  //     options: Options(contentType: Headers.jsonContentType),
  //   );
  // }

  Future<void> logout(String refreshToken) async {
    await _request(
      '/auth/logout',
      'POST',
      data: {'refresh_token': refreshToken},
      contentType: Headers.jsonContentType,
    );
  }

  //Recipes

  Future<Page<RecipeCard>> getRecipes({
    int page=1,
    int pageSize=10,
    String? category,
    String? search,
    String sort='newest',
    int? maxCookMinutes,
  }) async {
    final queryParameters = {'page': page, 'page_size': pageSize, 'sort': sort};

    if (category != null) {
      queryParameters['category'] = category;
    }
    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }
    if (maxCookMinutes != null) {
      queryParameters['max_cook_minutes'] = maxCookMinutes;
    }


    final response = await _request(
      '/recipes',
      'GET',
      queryParameters: queryParameters,
    );

    return Page<RecipeCard>.fromJson(response.data, RecipeCard.fromJson);
  }

  Future<FavoriteApiModel> toggleFavorite(String recipeId) async {
    final response = await _request(
      '/recipes/$recipeId/favorite',
      'POST',
    );
    return FavoriteApiModel.fromJson(response.data);
  }
}

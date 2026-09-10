import 'package:dio/dio.dart';

import '../../models/token_pair.dart';
import '../storage/token_storage.dart';
import 'api_config.dart';

class RefreshClient {

  final TokenStorage tokenStorage;

  RefreshClient(this.tokenStorage);

  final Dio _dio = Dio(
    BaseOptions(baseUrl: ApiConfig.baseUrl),
  );


  Future<TokenPair> refreshToken() async {

    final tokenPair = await tokenStorage.getTokenPair();
    if (tokenPair == null) {
      throw Exception('No token pair found');
    }

    final response = await _dio.post(
      '/auth/refresh',
      data: {'refresh_token': tokenPair.refreshToken},
    );
    final newToken = TokenPair.fromJson(response.data);
    await tokenStorage.saveTokenPair(newToken);
    return newToken;
  }

}
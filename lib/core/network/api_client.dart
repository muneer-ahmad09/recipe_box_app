import 'package:dio/dio.dart';
import 'package:recipe_box_app/core/network/auth_interceptor.dart';
import 'package:recipe_box_app/models/token_pair.dart';

import '../../models/user.dart';
import 'api_config.dart';

class ApiClient {
  final AuthInterceptor authInterceptor;

  ApiClient(this.authInterceptor) {
    authInterceptor.setDio(dio);
    dio.interceptors.add(authInterceptor);
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: ApiConfig.baseUrl),
  );

  Future<TokenPair> login(String email, String password) async {
    final response = await dio.post(
      '/auth/login',
      data: {'username': email, 'password': password},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return TokenPair.fromJson(response.data);
  }

  Future<User> getCurrentUser() async {
    final response = await dio.get(
      '/auth/me');
    return User.fromJson(response.data);
  }
}

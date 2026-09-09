import 'package:dio/dio.dart';
import 'package:recipe_box_app/models/token_pair.dart';

import '../../models/user.dart';
import '../storage/token_storage.dart';

class ApiClient {

  final Dio dio = Dio(
      BaseOptions(
          baseUrl: "https://27da-49-36-217-239.ngrok-free.app"
      )
  );

  Future<TokenPair> login(String email, String password) async {
    final response = await dio.post(
        '/auth/login',
        data: {
          'username': email,
          'password': password
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        )
    );
    return TokenPair.fromJson(response.data);
  }

  Future<User> getCurrentUser(String accessToken) async {
    final response = await dio.get('/auth/me',
        options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken'
            }
        )
    );
    return User.fromJson(response.data);
  }


}
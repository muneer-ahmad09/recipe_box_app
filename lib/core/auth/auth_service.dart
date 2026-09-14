import 'package:recipe_box_app/core/network/api_client.dart';
import 'package:recipe_box_app/models/token_pair.dart';
import 'package:recipe_box_app/models/user.dart';

import '../storage/token_storage.dart';

class AuthService {
  //dependency injection
  final ApiClient apiClient;
  final TokenStorage tokenStorage;
  const AuthService(this.apiClient, this.tokenStorage);

  Future<TokenPair> login(String email, String password) async {
    final tokenPair = await apiClient.login(email, password);
    await tokenStorage.saveTokenPair(tokenPair);
    return tokenPair;
  }

  Future <User> getCurrentUser() {
    return apiClient.getCurrentUser();
  }
  Future<TokenPair> register(String email , String password, String fullName) async{
    final tokenPair = await apiClient.register(email, password, fullName);
    await tokenStorage.saveTokenPair(tokenPair);
    return tokenPair;
  }

  Future<void> logout(String refreshToken) async {
    await apiClient.logout(refreshToken);
  }

}
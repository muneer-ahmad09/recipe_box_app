import 'package:recipe_box_app/core/network/api_client.dart';
import 'package:recipe_box_app/models/token_pair.dart';

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
}
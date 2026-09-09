import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_box_app/models/token_pair.dart';

class TokenStorage {
  final FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  Future<void> saveTokenPair(TokenPair tokenPair) async {
    await flutterSecureStorage.write(
      key: accessTokenKey,
      value: tokenPair.accessToken,
    );
    await flutterSecureStorage.write(
      key: refreshTokenKey,
      value: tokenPair.refreshToken,
    );
  }

  Future<TokenPair?> getTokenPair() async {
    final accessToken = await flutterSecureStorage.read(key: accessTokenKey);
    final refreshToken = await flutterSecureStorage.read(key: refreshTokenKey);

    if(accessToken == null || refreshToken == null){
      return null;
    }
    return TokenPair(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: 'bearer',
    );
  }

  Future<void> deleteTokenPair() async {
    await flutterSecureStorage.delete(key: accessTokenKey);
    await flutterSecureStorage.delete(key: refreshTokenKey);
  }

}
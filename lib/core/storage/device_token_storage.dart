import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceTokenStorage {
  static const String _registeredTokenKey = 'registered_fcm_token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Saves the FCM token after the backend successfully registers it.
  Future<void> saveToken(String token) async {
    await _storage.write(
      key: _registeredTokenKey,
      value: token,
    );
  }

  /// Returns the last token successfully registered with the backend.
  Future<String?> getToken() async {
    return _storage.read(key: _registeredTokenKey);
  }

  /// Removes the locally saved registered token.
  Future<void> deleteToken() async {
    await _storage.delete(key: _registeredTokenKey);
  }
}
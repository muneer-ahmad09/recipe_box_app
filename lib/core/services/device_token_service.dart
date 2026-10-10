import 'package:recipe_box_app/core/network/api_client.dart';

class DeviceTokenService {
  final ApiClient _apiClient;

  DeviceTokenService(this._apiClient);

  Future<void> register({
    required String token,
    required String platform,
  }) async {
    await _apiClient.registerDevice(
      token: token,
      platform: platform,
    );
  }

  Future<void> unregister({
    required String token,
    required String platform,
  }) async {
    await _apiClient.unregisterDevice(
      token: token,
      platform: platform,
    );
  }
}
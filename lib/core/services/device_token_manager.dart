import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:recipe_box_app/core/notifications/notification_service.dart';
import 'package:recipe_box_app/core/storage/device_token_storage.dart';

import 'device_token_service.dart';

class DeviceTokenManager {
  final NotificationService notificationService;
  final DeviceTokenService deviceTokenService;
  final DeviceTokenStorage deviceTokenStorage;


  DeviceTokenManager(
      this.notificationService,
      this.deviceTokenService,
      this.deviceTokenStorage,
      );

  StreamSubscription<String>? _tokenRefreshSubscription;
  bool _isEnabled = false;

  String? get _platform {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return null;
  }

  Future<void> registerDevice() async {
    final currentToken = await notificationService.getToken();
    final platform = _platform;

    if (currentToken == null ||
        currentToken.isEmpty ||
        platform == null) {
      return;
    }

    final registeredToken = await deviceTokenStorage.getToken();

    // Nothing changed, so don't make another registration request.
    if (registeredToken == currentToken) {
      return;
    }

    // Remove the previous token before registering the new one.
    if (registeredToken != null && registeredToken.isNotEmpty) {
      await deviceTokenService.unregister(
        token: registeredToken,
        platform: platform,
      );
    }

    // Save locally only after the backend registration succeeds.
    await deviceTokenService.register(
      token: currentToken,
      platform: platform,
    );

    await deviceTokenStorage.saveToken(currentToken);
  }

  Future<void> unregisterDevice() async {
    final registeredToken = await deviceTokenStorage.getToken();
    final platform = _platform;

    if (registeredToken == null ||
        registeredToken.isEmpty ||
        platform == null) {
      return;
    }

    await deviceTokenService.unregister(
      token: registeredToken,
      platform: platform,
    );

    // Delete the local record only after successful unregistration.
    await deviceTokenStorage.deleteToken();
  }

  Future<void> start() async {
    if (_isEnabled) return;

    _isEnabled = true;

    // Listen before registering, so token changes aren't missed.
    _tokenRefreshSubscription =
        notificationService.onTokenRefresh.listen((_) async {
          if (!_isEnabled) return;

          try {
            await registerDevice();
          } catch (error, stackTrace) {
            debugPrint('Failed to sync refreshed FCM token: $error');
            debugPrintStack(stackTrace: stackTrace);

          }
        });

    await registerDevice();
  }

  Future<void> stop() async {
    _isEnabled = false;

    await _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = null;

    await unregisterDevice();
  }
}
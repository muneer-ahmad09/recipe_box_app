import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
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
  Future<void>? _syncFuture;
  Future<void> _lifecycleFuture = Future<void>.value();

  Future<void> _runLifecycle(Future<void> Function() operation) {
    final next = _lifecycleFuture.then((_) => operation());

    // Keep the queue usable even if an operation fails.
    _lifecycleFuture = next.then<void>(
      (_) {},
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Device lifecycle operation failed: $error');
        debugPrintStack(stackTrace: stackTrace);
      },
    );

    // The original caller still receives any error.
    return next;
  }

  String? get _platform {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return null;
  }

  Future<void> registerDevice() {
    if (!_isEnabled) {
      return Future<void>.value();
    }

    final existingFuture = _syncFuture;

    if (existingFuture != null) {
      return existingFuture;
    }

    final future = _performSync();
    _syncFuture = future;

    return future.whenComplete(() {
      if (identical(_syncFuture, future)) {
        _syncFuture = null;
      }
    });
  }

  Future<void> _performSync() async {
    final currentToken = await notificationService.getToken();
    final platform = _platform;

    if (currentToken == null || currentToken.isEmpty || platform == null) {
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
    await deviceTokenService.register(token: currentToken, platform: platform);

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

  Future<void> start() {
    return _runLifecycle(_startInternal);
  }

  Future<void> stop() {
    return _runLifecycle(_stopInternal);
  }

  Future<void> _startInternal() async {
    if (!_isEnabled) {
      _isEnabled = true;

      _tokenRefreshSubscription = notificationService.onTokenRefresh.listen((
        _,
      ) async {
        if (!_isEnabled) return;

        try {
          await registerDevice();
        } catch (error, stackTrace) {
          debugPrint('Failed to sync refreshed FCM token: $error');
          debugPrintStack(stackTrace: stackTrace);
        }
      });
    }

    // Also retry registration if start() is called again.
    await registerDevice();
  }

  Future<void> _stopInternal() async {
    // Prevent new refresh-triggered registrations.
    _isEnabled = false;

    await _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = null;

    // Wait for any registration already in progress.
    final ongoingSync = _syncFuture;

    if (ongoingSync != null) {
      try {
        await ongoingSync;
      } catch (error, stackTrace) {
        debugPrint('Ongoing device sync failed during logout: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    }

    // Now unregister the last successfully registered token.
    await unregisterDevice();
  }
}

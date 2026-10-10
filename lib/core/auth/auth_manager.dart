import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, debugPrint, debugPrintStack;
import 'package:recipe_box_app/core/auth/auth_service.dart';
import 'package:recipe_box_app/core/storage/token_storage.dart';
import 'package:recipe_box_app/models/user.dart';

import '../services/device_token_manager.dart';
import 'auth_state.dart';

class AuthManager extends ChangeNotifier {
  final AuthService authService;
  final TokenStorage tokenStorage;
  final DeviceTokenManager deviceTokenManager;

  AuthManager(this.authService, this.tokenStorage, this.deviceTokenManager);

  AuthState _authState = AuthState.initializing;
  User? _user;

  AuthState get authState => _authState;

  User? get user => _user;

  String? _initializationError;

  String? get initializationError => _initializationError;

  void setInitializationError(String error) {
    _initializationError = error;
    notifyListeners();
  }

  void setAuthState(AuthState state) {
    _authState = state;
    notifyListeners();
  }

  void _startInitialization() {
    _authState = AuthState.initializing;
    _initializationError = null;
    notifyListeners();
  }

  // Future<void> initialize() async {
  //   _startInitialization();
  //   try {
  //     final tokenPair = await tokenStorage.getTokenPair();
  //     if (tokenPair == null) {
  //       setAuthState(AuthState.unauthenticated);
  //       return;
  //     } else {
  //       final user = await authService.getCurrentUser();
  //       _user = user;
  //       await deviceTokenManager.start();
  //       setAuthState(AuthState.authenticated);
  //     }
  //   } on DioException catch (err) {
  //     if (err.response?.statusCode == 401) {
  //       setAuthState(AuthState.unauthenticated);
  //     } else {
  //       setInitializationError('Failed to fetch user data');
  //     }
  //   } catch (_) {
  //     setInitializationError('Unable to check your saved session');
  //   }
  // }

  Future<void> initialize() async {
    _startInitialization();

    try {
      final tokenPair = await tokenStorage.getTokenPair();

      if (tokenPair == null) {
        _user = null;
        setAuthState(AuthState.unauthenticated);
        return;
      }

      final user = await authService.getCurrentUser();

      _user = user;

      // Authentication is valid; notification registration is secondary.
      setAuthState(AuthState.authenticated);

      try {
        await deviceTokenManager.start();
      } catch (error, stackTrace) {
        debugPrint('Device registration failed during initialization: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        _user = null;
        setAuthState(AuthState.unauthenticated);
      } else {
        setInitializationError('Failed to fetch user data');
      }
    } catch (error, stackTrace) {
      debugPrint('Session initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      setInitializationError('Unable to check your saved session');
    }
  }

  Future<void> login(String email, String password) async {
    await authService.login(email, password);
    _user = await authService.getCurrentUser();

    setAuthState(AuthState.authenticated);

    try {
      await deviceTokenManager.start();
    } catch (error, stackTrace) {
      debugPrint('Device registration failed after login: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> register(
      String email,
      String password,
      String fullName,
      ) async {
    await authService.register(email, password, fullName);

    _user = await authService.getCurrentUser();

    setAuthState(AuthState.authenticated);

    try {
      await deviceTokenManager.start();
    } catch (error, stackTrace) {
      debugPrint('Device registration failed after signup: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> logout() async {
    final tokenPair = await tokenStorage.getTokenPair();

    if (tokenPair == null) {
      _user = null;
      setAuthState(AuthState.unauthenticated);
      return;
    }

    await _unregisterDeviceSafely();
    await _logoutFromServerSafely(tokenPair.refreshToken);

    await tokenStorage.deleteTokenPair();
    _user = null;
    setAuthState(AuthState.unauthenticated);
  }

  Future<void> _unregisterDeviceSafely() async {
    try {
      await deviceTokenManager.stop();
    } catch (error, stackTrace) {
      debugPrint('Device unregistration failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _logoutFromServerSafely(String refreshToken) async {
    try {
      await authService.logout(refreshToken);
    } catch (error, stackTrace) {
      debugPrint('Server logout failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}

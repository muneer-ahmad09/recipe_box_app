import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:recipe_box_app/core/auth/auth_service.dart';
import 'package:recipe_box_app/core/storage/token_storage.dart';
import 'package:recipe_box_app/models/user.dart';

import 'auth_state.dart';

class AuthManager extends ChangeNotifier {
  final AuthService authService;
  final TokenStorage tokenStorage;

  AuthManager(this.authService, this.tokenStorage);

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

  Future<void> initialize() async {
    _startInitialization();
    try {
      final tokenPair = await tokenStorage.getTokenPair();
      if (tokenPair == null) {
        setAuthState(AuthState.unauthenticated);
        return;
      } else {
        final user = await authService.getCurrentUser();
        _user = user;
        setAuthState(AuthState.authenticated);
      }
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        setAuthState(AuthState.unauthenticated);
      } else {
        setInitializationError('Failed to fetch user data');
      }
    } catch (_) {
      setInitializationError('Unable to check your saved session');
    }
  }

  Future<void> login(String email, String password) async{
    await authService.login(email, password);
    _user = await authService.getCurrentUser();
    setAuthState(AuthState.authenticated);
  }


}

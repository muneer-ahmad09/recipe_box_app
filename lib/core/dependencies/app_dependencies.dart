import '../auth/auth_manager.dart';
import '../auth/auth_service.dart';
import '../network/api_client.dart';
import '../network/auth_interceptor.dart';
import '../network/refresh_client.dart';
import '../storage/token_storage.dart';

class AppDependencies {
  final TokenStorage _tokenStorage = TokenStorage();

  late final RefreshClient _refreshClient = RefreshClient(_tokenStorage);

  late final AuthInterceptor _authInterceptor = AuthInterceptor(
    _tokenStorage,
    refreshClient: _refreshClient,
  );
  late final ApiClient _apiClient = ApiClient(_authInterceptor);
  late final AuthService _authService = AuthService(_apiClient, _tokenStorage);
  late final AuthManager authManager = AuthManager(_authService, _tokenStorage);
}
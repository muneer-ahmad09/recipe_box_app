import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_manager.dart';
import '../auth/auth_service.dart';
import '../network/api_client.dart';
import '../network/auth_interceptor.dart';
import '../network/refresh_client.dart';
import '../services/cloudinary_service.dart';
import '../services/recipe_service.dart';
import '../storage/token_storage.dart';
import 'add_recipe/add_recipe_validation.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final refreshClientProvider = Provider<RefreshClient>((ref) {
  final tokenStorage = ref.read(tokenStorageProvider);

  return RefreshClient(tokenStorage);
});

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  final tokenStorage = ref.read(tokenStorageProvider);
  final refreshClient = ref.read(refreshClientProvider);

  return AuthInterceptor(
    tokenStorage,
    refreshClient: refreshClient,
  );
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final authInterceptor = ref.read(authInterceptorProvider);

  return ApiClient(authInterceptor);
});

final recipeServiceProvider = Provider<RecipeService>((ref) {
  final apiClient = ref.read(apiClientProvider);

  return RecipeService(apiClient);
});

final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final tokenStorage = ref.read(tokenStorageProvider);
  return AuthService(apiClient, tokenStorage);
});

final authManagerProvider = Provider<AuthManager>((ref) {
  final authService = ref.read(authServiceProvider);
  final tokenStorage = ref.read(tokenStorageProvider);
  return AuthManager(authService, tokenStorage);
});

final addRecipeValidatorProvider = Provider<AddRecipeValidator>((ref) {
  return AddRecipeValidator();
});

final cloudinaryDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
});

final cloudinaryServiceProvider = Provider<CloudinaryService>((ref) {
  final apiClient = ref.read(apiClientProvider);

  return CloudinaryService(
    apiClient: apiClient,
    dio: ref.read(cloudinaryDioProvider),
  );
});
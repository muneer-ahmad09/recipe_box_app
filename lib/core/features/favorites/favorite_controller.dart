import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/services/recipe_service.dart';
import 'package:recipe_box_app/models/favorite_api_model.dart';

import '../../network/api_exception.dart';
import '../providers.dart';
import 'favorite_state.dart';

class FavoriteController extends Notifier<FavoriteState> {
  late final RecipeService _recipeService;

  @override
  FavoriteState build() {
    _recipeService = ref.read(recipeServiceProvider);

    return const FavoriteState();
  }

  Future<FavoriteApiModel?> toggleFavorite(String recipeId) async {
    if (state.loadingIds.contains(recipeId)) {
      return null;
    }

    final loadingIds = {
      ...state.loadingIds,
      recipeId,
    };

    state = state.copyWith(
      loadingIds: loadingIds,
      errorMessage: null,
    );

    try {
      final result = await _recipeService.toggleFavorite(recipeId);

      return result;
    } on ApiException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
      );

      return null;
    } catch (_) {
      state = state.copyWith(
        errorMessage: 'Something went wrong. Please try again.',
      );

      return null;
    } finally {
      final updatedLoadingIds = {
        ...state.loadingIds,
      };

      updatedLoadingIds.remove(recipeId);

      state = state.copyWith(
        loadingIds: updatedLoadingIds,
      );
    }
  }}

final favoriteProvider =
NotifierProvider<FavoriteController, FavoriteState>(
  FavoriteController.new,
);
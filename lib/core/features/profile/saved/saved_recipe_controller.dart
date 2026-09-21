import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../network/api_exception.dart';
import '../../../services/recipe_service.dart';
import '../../providers.dart';
import 'saved_recipe_state.dart';

class SavedRecipeController
    extends Notifier<SavedRecipeState> {
  late final RecipeService _recipeService;

  @override
  SavedRecipeState build() {
    _recipeService = ref.read(recipeServiceProvider);

    return const SavedRecipeState();
  }

  Future<void> loadInitial() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final response = await _recipeService.getSavedRecipes(
        page: 1,
        pageSize: 10,
      );

      state = state.copyWith(
        recipes: response.items,
        currentPage: response.page,
        totalPages: response.pages,
        isLoading: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }

    state = state.copyWith(
      isLoadingMore: true,
    );

    try {
      final nextPage = state.currentPage + 1;

      final response = await _recipeService.getSavedRecipes(
        page: nextPage,
        pageSize: 10,
      );

      state = state.copyWith(
        recipes: [
          ...state.recipes,
          ...response.items,
        ],
        currentPage: response.page,
        totalPages: response.pages,
        isLoadingMore: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }
}

final savedRecipeProvider =
NotifierProvider<SavedRecipeController, SavedRecipeState>(
  SavedRecipeController.new,
);



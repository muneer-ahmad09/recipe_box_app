import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/bookmarked/bookmarked_state.dart';

import '../../network/api_exception.dart';
import '../../services/recipe_service.dart';
import '../providers.dart';

class BookmarkedController extends Notifier<BookmarkedState> {
  late final RecipeService _recipeService;

  @override
  BookmarkedState build() {
    _recipeService = ref.read(recipeServiceProvider);

    return const BookmarkedState();
  }

  Future<void> loadInitial() async {
    // Don't make the same initial request twice.
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

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
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoadingMore: true, clearError: true);

    try {
      final nextPage = state.currentPage + 1;

      final response = await _recipeService.getSavedRecipes(
        page: nextPage,
        pageSize: 10,
      );

      state = state.copyWith(
        recipes: [...state.recipes, ...response.items],
        currentPage: response.page,
        totalPages: response.pages,
        isLoadingMore: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  void updateFavorite(String recipeId, bool isFavorite) {
    final recipes = [...state.recipes];

    final index = recipes.indexWhere((recipe) => recipe.id == recipeId);

    if (index == -1) {
      return;
    }

    // If the recipe was unsaved, remove it
    // from the saved recipes list.
    if (!isFavorite) {
      recipes.removeAt(index);
    } else {
      recipes[index] = recipes[index].copyWith(isFavorite: true);
    }

    state = state.copyWith(recipes: recipes);
  }
}

final bookmarkedProvider =
    NotifierProvider<BookmarkedController, BookmarkedState>(
      BookmarkedController.new,
    );

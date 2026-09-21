import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/api_exception.dart';
import '../../services/recipe_service.dart';
import '../providers.dart';
import 'all_recipes_state.dart';

class AllRecipesController extends Notifier<AllRecipesState> {
  late final RecipeService _recipeService;

  int _requestId = 0;

  @override
  AllRecipesState build() {
    _recipeService = ref.read(recipeServiceProvider);

    Future.microtask(() {
      loadRecipes(page: 1);
    });

    return const AllRecipesState();
  }

  Future<void> loadRecipes({required int page}) async {
    final requestId = ++_requestId;

    final filter = state.selectedFilter;
    final isFirstPage = page == 1;

    state = state.copyWith(
      isInitialLoading: isFirstPage,
      isLoadingMore: !isFirstPage,
      errorMessage: null,
      failedPage: null,
    );

    try {
      final response = await _recipeService.getRecipes(
        page: page,
        sort: _getSort(filter),
        maxCookMinutes: _getMaxCookMinutes(filter),
      );

      // Ignore this response if a newer request has started.
      if (requestId != _requestId) {
        return;
      }

      if (isFirstPage) {
        state = state.copyWith(
          recipes: response.items,
          currentPage: response.page,
          hasMore: response.page < response.pages,
          isInitialLoading: false,
          isLoadingMore: false,
          errorMessage: null,
          failedPage: null,
        );
      } else {
        final updatedRecipes = [...state.recipes, ...response.items];

        state = state.copyWith(
          recipes: updatedRecipes,
          currentPage: response.page,
          hasMore: response.page < response.pages,
          isInitialLoading: false,
          isLoadingMore: false,
          errorMessage: null,
          failedPage: null,
        );
      }
    } on ApiException catch (e) {
      if (requestId != _requestId) {
        return;
      }

      state = state.copyWith(
        isInitialLoading: false,
        isLoadingMore: false,
        errorMessage: e.message,
        failedPage: page,
      );
    } catch (_) {
      if (requestId != _requestId) {
        return;
      }

      state = state.copyWith(
        isInitialLoading: false,
        isLoadingMore: false,
        errorMessage: 'Something went wrong. Please try again.',
        failedPage: page,
      );
    }
  }

  Future<void> changeFilter(String filter) async {
    state = state.copyWith(
      selectedFilter: filter,
      recipes: const [],
      currentPage: 1,
      hasMore: true,
      isInitialLoading: true,
      isLoadingMore: false,
      errorMessage: null,
      failedPage: null,
    );

    await loadRecipes(page: 1);
  }

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    await loadRecipes(page: state.currentPage + 1);
  }

  void updateFavorite(String recipeId, bool isFavorite) {
    final index = state.recipes.indexWhere((recipe) => recipe.id == recipeId);

    if (index == -1) {
      return;
    }

    final updatedRecipes = [...state.recipes];

    updatedRecipes[index] = updatedRecipes[index].copyWith(
      isFavorite: isFavorite,
    );

    state = state.copyWith(recipes: updatedRecipes);
  }

  Future<void> retry() async {
    final failedPage = state.failedPage;

    if (failedPage == null) {
      await loadRecipes(page: 1);
      return;
    }

    await loadRecipes(page: failedPage);
  }

  String? _getSort(String filter) {
    switch (filter) {
      case 'Newest':
        return 'newest';

      case 'Popular':
        return 'popular';

      case 'Under 30 Min':
        return null;

      default:
        return 'newest';
    }
  }

  int? _getMaxCookMinutes(String filter) {
    switch (filter) {
      case 'Under 30 Min':
        return 30;

      default:
        return null;
    }
  }
}

final allRecipesProvider =
    NotifierProvider<AllRecipesController, AllRecipesState>(
      AllRecipesController.new,
    );

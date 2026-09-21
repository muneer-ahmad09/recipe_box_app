import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/search/search_state.dart';
import 'package:recipe_box_app/core/services/recipe_service.dart';

import '../../network/api_exception.dart';
import '../../services/search_service.dart';
import '../providers.dart';

class SearchController extends Notifier<SearchState> {
  late final SearchService _searchService;
  late final RecipeService _recipeService;

  @override
  SearchState build() {
    _searchService = ref.read(searchServiceProvider);
    _recipeService = ref.read(recipeServiceProvider);
    return const SearchState();
  }

  void changeSearchType(SearchType type) {
    state = state.copyWith(
      searchType: type,
      query: '',
      recipeResults: null,
      userResults: null,
      status: SearchStatus.idle,
      errorMessage: null,
    );
  }

  void updateFavorite(String recipeId, bool isFavorite) {
    final recipes = state.recipeResults?.items ?? [];
    final index = recipes.indexWhere((recipe) => recipe.id == recipeId);

    if (index == -1) {
      return;
    }

    final updatedRecipes = [...recipes];

    updatedRecipes[index] = updatedRecipes[index].copyWith(
      isFavorite: isFavorite,
    );

    state = state.copyWith(
      recipeResults: state.recipeResults!.copyWith(items: updatedRecipes),
    );
  }

  void changeQuery(String query) {
    state = state.copyWith(query: query);
  }

  Future<void> search() async {
    final query = state.query.trim();

    if (state.status == SearchStatus.loading) {
      return;
    }
    if (query.isEmpty && state.searchType == SearchType.recipe) {
      state = state.copyWith(recipeResults: null);
      return;
    }

    if (query.isEmpty && state.searchType == SearchType.user) {
      state = state.copyWith(userResults: null);
      return;
    }

    state = state.copyWith(status: SearchStatus.loading, errorMessage: null);
    try {
      switch (state.searchType) {
        case SearchType.recipe:
          final response = await _recipeService.getRecipes(search: query);
          state = state.copyWith(
            recipeResults: response,
            status: SearchStatus.idle,
          );
          break;
        case SearchType.user:
          final response = await _searchService.searchUsers(query: query);
          state = state.copyWith(
            userResults: response,
            status: SearchStatus.idle,
          );

          break;
      }
    } on ApiException catch (e) {
      state = state.copyWith(
        status: SearchStatus.error,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(status: SearchStatus.error);
    }
  }
}

final searchProvider = NotifierProvider<SearchController, SearchState>(
  SearchController.new,
);

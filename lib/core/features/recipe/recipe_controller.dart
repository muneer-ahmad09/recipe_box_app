import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/recipe_service.dart';
import '../providers.dart';
import 'recipe_state.dart';

class RecipeController extends Notifier<RecipeState> {
  late final RecipeService _recipeService;

  @override
  RecipeState build() {
    _recipeService = ref.read(recipeServiceProvider);

    return const RecipeState();
  }

  Future<void> loadRecipe(String id) async {
    state = state.copyWith(
      isLoading: true,
      recipe: null,
      errorMessage: null,
    );

    try {
      final recipe = await _recipeService.getRecipe(id);

      state = state.copyWith(
        isLoading: false,
        recipe: recipe,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong',
        recipe: null,
      );
    }
  }

  void updateFavorite(bool isFavorite) {
    final recipe = state.recipe;

    if (recipe == null) {
      return;
    }

    state = state.copyWith(
      recipe: recipe.copyWith(
        isFavorite: isFavorite,
      ),
    );
  }
}

final recipeProvider =
NotifierProvider<RecipeController, RecipeState>(
  RecipeController.new,
);
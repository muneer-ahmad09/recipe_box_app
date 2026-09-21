import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/profile/recipes/profile_recipe_state.dart';

import '../../../network/api_exception.dart';
import '../../../services/recipe_service.dart';
import '../../providers.dart';

class ProfileRecipeController
    extends Notifier<ProfileRecipeState> {

  late final RecipeService _recipeService;

  @override
  ProfileRecipeState build() {
    _recipeService = ref.read(recipeServiceProvider);

    return const ProfileRecipeState();
  }

  Future<void> loadMyRecipes() async {
    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      recipes: [],
      currentPage: 0,
      totalPages: 0,
      clearError: true,
    );

    try {
      final result = await _recipeService.getMyRecipes(
        page: 1,
        pageSize: 10,
      );

      state = state.copyWith(
        recipes: result.items,
        currentPage: result.page,
        totalPages: result.pages,
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

      final result = await _recipeService.getMyRecipes(
        page: nextPage,
        pageSize: 10,
      );

      state = state.copyWith(
        recipes: [
          ...state.recipes,
          ...result.items,
        ],
        currentPage: result.page,
        totalPages: result.pages,
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
final profileRecipeProvider =
NotifierProvider<ProfileRecipeController, ProfileRecipeState>(
  ProfileRecipeController.new,
);
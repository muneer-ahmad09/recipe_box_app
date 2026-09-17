import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/providers.dart';
import 'package:recipe_box_app/core/network/api_exception.dart';
import 'package:recipe_box_app/core/services/recipe_service.dart';
import 'package:recipe_box_app/models/recipe_create_request.dart';

import '../../../models/recipe_detail.dart';
import '../../../models/recipe_enums.dart';
import '../../services/cloudinary_service.dart';
import 'add_recipe_state.dart';
import 'add_recipe_validation.dart';

class AddRecipeController extends Notifier<AddRecipeState> {
  late final RecipeService _recipeService;
  late final AddRecipeValidator _validator;
  late final CloudinaryService _cloudinaryService;

  @override
  AddRecipeState build() {
    _recipeService = ref.read(recipeServiceProvider);
    _validator = ref.read(addRecipeValidatorProvider);
    _cloudinaryService = ref.read(cloudinaryServiceProvider);
    return const AddRecipeState();
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title, titleError: null);
  }

  void updateImage(File image) {
    state = state.copyWith(image: image);
  }

  void updateCategory(Category category) {
    state = state.copyWith(category: category, categoryError: null);
  }

  void updateDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty, difficultyError: null);
  }

  void updateCookingTime(int cookingTime) {
    state = state.copyWith(cookingTime: cookingTime, cookingTimeError: null);
  }

  void updateIngredients(List<String> ingredients) {
    state = state.copyWith(ingredients: ingredients, ingredientsError: null);
  }

  void updateSteps(List<String> steps) {
    state = state.copyWith(steps: steps, stepsError: null);
  }

  void reset() {
    state = const AddRecipeState();
  }

  Future<RecipeDetail?> saveRecipe() async {
    if(state.status == AddRecipeStatus.saving){
      return null;
    }
    final result = _validator.validate(state);

    if (!result.isValid) {
      state = state.copyWith(
        titleError: result.titleError,
        categoryError: result.categoryError,
        difficultyError: result.difficultyError,
        cookingTimeError: result.cookingTimeError,
        ingredientsError: result.ingredientsError,
        stepsError: result.stepsError,
      );

      return null;
    }

    state = state.copyWith(status: AddRecipeStatus.saving, errorMessage: null);
    try {
      String? imageUrl;

      if (state.image != null) {
        imageUrl = await _cloudinaryService.uploadImage(state.image!);
      }

      final request = RecipeCreateRequest(
        title: state.title.trim(),
        category: state.category!,
        difficulty: state.difficulty!,
        cookMinutes: state.cookingTime,
        ingredients: state.ingredients
            .map((ingredient) => ingredient.trim())
            .toList(),
        steps: state.steps.map((step) => step.trim()).toList(),
        imageUrl: imageUrl,
      );

      final recipe = await _recipeService.createRecipe(request);
      state = state.copyWith(status: AddRecipeStatus.success);
      return recipe;
    } on ApiException catch (e) {
      state = state.copyWith(
        status: AddRecipeStatus.error,
        errorMessage: e.message,
      );
    }catch (_) {
      state = state.copyWith(
        status: AddRecipeStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }

    return null;
  }
}

final addRecipeProvider = NotifierProvider<AddRecipeController, AddRecipeState>(
  AddRecipeController.new,
);

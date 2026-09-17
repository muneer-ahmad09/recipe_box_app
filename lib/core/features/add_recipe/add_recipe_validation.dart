import 'add_recipe_state.dart';

class AddRecipeValidator {
  AddRecipeValidationResult validate(AddRecipeState state) {
    String? titleError;

    String? categoryError;
    String? cookingTimeError;

    String? difficultyError;
    String? ingredientsError;
    String? stepsError;



    final title = state.title.trim();

    if (title.isEmpty) {
      titleError = 'Recipe name is required';
    }

    if (state.cookingTime <= 0) {
      cookingTimeError = 'Cooking time must be greater than 0';
    } else if (state.cookingTime > 1440) {
      cookingTimeError = 'Cooking time cannot exceed 1440 minutes';
    }

    if (state.difficulty == null) {
      difficultyError = 'Please select a difficulty';
    }

    if (state.category == null) {
      categoryError = 'Please select a category';
    }


    if (state.ingredients.isEmpty ||
        state.ingredients.any((ingredient) => ingredient.trim().isEmpty)) {
      ingredientsError = 'Please add at least one ingredient';
    }

    if (state.steps.isEmpty ||
        state.steps.any((step) => step.trim().isEmpty)) {
      stepsError = 'Please add at least one step';
    }

    return AddRecipeValidationResult(
      titleError: titleError,
      categoryError: categoryError,
      difficultyError: difficultyError,
      cookingTimeError: cookingTimeError,
      ingredientsError: ingredientsError,
      stepsError: stepsError,
    );
  }
}

class AddRecipeValidationResult {
  final String? titleError;
  final String? categoryError;
  final String? difficultyError;
  final String? cookingTimeError;
  final String? ingredientsError;
  final String? stepsError;

  const AddRecipeValidationResult({
    this.titleError,
    this.categoryError,
    this.difficultyError,
    this.cookingTimeError,
    this.ingredientsError,
    this.stepsError,
  });

  bool get isValid =>
      titleError == null &&
      categoryError == null &&
      difficultyError == null &&
      cookingTimeError == null &&
      ingredientsError == null &&
      stepsError == null;
}

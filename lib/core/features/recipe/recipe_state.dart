import '../../../models/recipe_detail.dart';

class RecipeState {
  final RecipeDetail? recipe;
  final bool isLoading;
  final String? errorMessage;

  const RecipeState({
    this.recipe,
    this.isLoading = false,
    this.errorMessage,
  });

  static const _undefined = Object();

  RecipeState copyWith({
    Object? recipe = _undefined,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RecipeState(
      recipe: recipe == _undefined
          ? this.recipe
          : recipe as RecipeDetail?,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
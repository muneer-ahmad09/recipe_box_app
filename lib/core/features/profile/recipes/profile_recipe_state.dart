import '../../../../models/recipe_card.dart';
class ProfileRecipeState {
  final List<RecipeCard> recipes;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;

  final int currentPage;
  final int totalPages;

  const ProfileRecipeState({
    this.recipes = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
  });

  bool get hasMore => currentPage < totalPages;

  ProfileRecipeState copyWith({
    List<RecipeCard>? recipes,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool clearError = false,
  }) {
    return ProfileRecipeState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
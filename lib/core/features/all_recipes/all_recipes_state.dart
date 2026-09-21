import '../../../models/recipe_card.dart';

class AllRecipesState {
  static const _unset = Object();

  final String selectedFilter;
  final List<RecipeCard> recipes;

  final int currentPage;
  final bool hasMore;

  final bool isInitialLoading;
  final bool isLoadingMore;

  final String? errorMessage;
  final int? failedPage;

  const AllRecipesState({
    this.selectedFilter = 'Newest',
    this.recipes = const [],
    this.currentPage = 1,
    this.hasMore = true,
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.errorMessage,
    this.failedPage,
  });

  AllRecipesState copyWith({
    String? selectedFilter,
    List<RecipeCard>? recipes,
    int? currentPage,
    bool? hasMore,
    bool? isInitialLoading,
    bool? isLoadingMore,

    Object? errorMessage = _unset,
    Object? failedPage = _unset,
  }) {
    return AllRecipesState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      recipes: recipes ?? this.recipes,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isInitialLoading:
      isInitialLoading ?? this.isInitialLoading,
      isLoadingMore:
      isLoadingMore ?? this.isLoadingMore,

      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,

      failedPage: identical(failedPage, _unset)
          ? this.failedPage
          : failedPage as int?,
    );
  }
}
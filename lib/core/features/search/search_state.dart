import '../../../models/page.dart';
import '../../../models/recipe_card.dart';
import '../../../models/user_card_model.dart';

class SearchState {
  static const _unset = Object();

  final SearchType searchType;
  final String query;
  final Page<RecipeCard>? recipeResults;
  final Page<UserCardModel>? userResults;
  final SearchStatus status;
  final String? errorMessage;

  const SearchState({
    this.searchType = SearchType.recipe,
    this.query = '',
    this.recipeResults,
    this.userResults,
    this.status = SearchStatus.idle,
    this.errorMessage,
  });

  SearchState copyWith({
    SearchType? searchType,
    String? query,
    SearchStatus? status,
    Set<String>? favoriteLoadingIds,
    Object? recipeResults = _unset,
    Object? userResults = _unset,
    Object? errorMessage = _unset,
  }) {
    return SearchState(
      searchType: searchType ?? this.searchType,
      query: query ?? this.query,
      recipeResults: identical(recipeResults, _unset)
          ? this.recipeResults
          : recipeResults as Page<RecipeCard>?,
      userResults: identical(userResults, _unset)
          ? this.userResults
          : userResults as Page<UserCardModel>?,
      status: status ?? this.status,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

enum SearchType { recipe, user }

enum SearchStatus { idle, loading, error }

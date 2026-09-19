import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/features/search/search_controller.dart';
import '../../core/features/search/search_state.dart';
import '../../models/recipe_enums.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/options_tab.dart';
import '../../widgets/saved_recipe_card.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFavorite(String recipeId, SearchController searchController) {
    searchController.toggleFavorite(recipeId);
  }

  Widget _buildSearchResultSection(
    SearchState searchState,
    SearchController searchController,
  ) {
    if (searchState.status == SearchStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchState.status == SearchStatus.error) {
      return Center(
        child: Text(searchState.errorMessage ?? 'Something went wrong'),
      );
    }

    if (searchState.searchType == SearchType.recipe) {
      if (searchState.recipeResults == null) {
        return const Center(child: Text('Search for recipes'));
      }

      final recipes = searchState.recipeResults!.items;

      if (recipes.isEmpty) {
        return const Center(child: Text('No recipes found'));
      }

      return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return SavedAndSearchRecipeCard(
            recipeName: recipe.title,
            recipeImageUrl: recipe.imageUrl,
            recipeTime: recipe.cookMinutes,
            recipeCategory: categoryEnumToString(recipe.category),
            isFavorite: recipe.isFavorite,
            onTapFavorite: () {
              _toggleFavorite(recipe.id, searchController);
            },
            isFavoriteLoading: searchState.favoriteLoadingIds.contains(
              recipe.id,
            ),
          );
        },
      );
    }

    // User results will come here.
    return const Center(child: Text('Search for users'));
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final searchController = ref.read(searchProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
          CustomSearchBar(
            controller: _searchController,
            hintText: "Search recipes and users",
            onSearch: (query) {
              searchController.changeQuery(query);
              searchController.search();
              _searchController.clear();
            },
          ),
          OptionsTabs(
            options: ["Recipe", "User"],
            changeValue: (String value) {
              searchController.changeSearchType(
                value == "Recipe" ? SearchType.recipe : SearchType.user,
              );
            },
          ),

          Expanded(
            child: _buildSearchResultSection(searchState, searchController),
          ),
        ],
      ),
    );
  }
}

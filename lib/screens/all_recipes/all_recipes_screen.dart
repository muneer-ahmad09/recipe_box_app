import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/favorites/favorite_state.dart';

import '../../core/features/all_recipes/all_recipes_controller.dart';
import '../../core/features/all_recipes/all_recipes_state.dart';
import '../../core/features/favorites/favorite_controller.dart';
import '../../models/recipe_enums.dart';
import '../../widgets/saved_recipe_card.dart';
import 'widgets/categories_tab.dart';

class AllRecipesScreen extends ConsumerStatefulWidget {
  const AllRecipesScreen({super.key});

  @override
  ConsumerState<AllRecipesScreen> createState() =>
      _AllRecipesScreenState();
}

class _AllRecipesScreenState
    extends ConsumerState<AllRecipesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    // Check after the first frame in case the first page
    // doesn't produce enough content to make the list scrollable.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfMorePagesNeeded();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = ref.read(allRecipesProvider);

    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(allRecipesProvider.notifier).loadNextPage();
    }
  }

  void _checkIfMorePagesNeeded() {
    if (!_scrollController.hasClients) {
      return;
    }

    final state = ref.read(allRecipesProvider);

    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    // There isn't enough content to scroll.
    // Load another page automatically.
    if (_scrollController.position.maxScrollExtent == 0) {
      ref.read(allRecipesProvider.notifier).loadNextPage();
    }
  }

  Future<void> _toggleFavorite(String recipeId) async {
    final result = await ref
        .read(favoriteProvider.notifier)
        .toggleFavorite(recipeId);

    if (result == null || !mounted) {
      return;
    }

    final allRecipesController =
    ref.read(allRecipesProvider.notifier);

    allRecipesController.updateFavorite(
      recipeId,
      result.isFavorite,
    );
  }

  Widget _buildRecipeSection(AllRecipesState state,FavoriteState favoriteState) {
    if (state.isInitialLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.errorMessage != null && state.recipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(allRecipesProvider.notifier)
                    .retry();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.recipes.isEmpty) {
      return const Center(
        child: Text('No recipes found'),
      );
    }

    final showBottomItem =
        state.isLoadingMore || state.errorMessage != null;

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: state.recipes.length +
          (showBottomItem ? 1 : 0),
      itemBuilder: (context, index) {
        // Bottom loading/error widget
        if (index == state.recipes.length) {
          if (state.isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  state.errorMessage ??
                      'Something went wrong.',
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(allRecipesProvider.notifier)
                        .retry();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final recipe = state.recipes[index];

        return SavedAndSearchRecipeCard(
          recipeName: recipe.title,
          recipeImageUrl: recipe.imageUrl,
          recipeTime: recipe.cookMinutes,
          recipeCategory:
          categoryEnumToString(recipe.category),
          isFavorite: recipe.isFavorite,
          onTapFavorite: () {
            _toggleFavorite(recipe.id);
          },

          isFavoriteLoading:
          favoriteState.loadingIds.contains(recipe.id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(allRecipesProvider);
    final favoriteState = ref.watch(favoriteProvider);

    // Whenever recipes are added, check whether the newly
    // loaded content is enough to make the list scrollable.
    ref.listen<AllRecipesState>(
      allRecipesProvider,
          (previous, next) {
        if (previous?.recipes.length != next.recipes.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkIfMorePagesNeeded();
          });
        }
      },
    );

    ref.listen<FavoriteState>(
      favoriteProvider,
          (previous, next) {
        if (next.errorMessage != null &&
            next.errorMessage != previous?.errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
            ),
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Recipes'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CategoriesTab(
              selectedCategory: state.selectedFilter,
              onCategoryChanged: (value) {
                if (_scrollController.hasClients) {
                  _scrollController.jumpTo(0);
                }

                ref
                    .read(allRecipesProvider.notifier)
                    .changeFilter(value);
              },
            ),
          ),

          Expanded(
            child: _buildRecipeSection(state, favoriteState),
          ),
        ],
      ),
    );
  }
}
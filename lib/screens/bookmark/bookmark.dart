import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/bookmarked/bookmarked_controller.dart';

import '../../core/features/favorites/favorite_controller.dart';
import '../../widgets/saved_recipe_card.dart';


class Bookmark extends ConsumerStatefulWidget {
  const Bookmark({super.key});

  @override
  ConsumerState<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends ConsumerState<Bookmark> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(bookmarkedProvider.notifier)
          .loadInitial();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >=
        position.maxScrollExtent - 300) {
      ref
          .read(bookmarkedProvider.notifier)
          .loadNextPage();
    }
  }

  Future<void> _toggleFavorite(String recipeId) async {
    final result = await ref
        .read(favoriteProvider.notifier)
        .toggleFavorite(recipeId);

    if (result == null || !mounted) {
      return;
    }

    ref
        .read(bookmarkedProvider.notifier)
        .updateFavorite(
      recipeId,
      result.isFavorite,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookmarkedProvider);

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.errorMessage != null &&
        state.recipes.isEmpty) {
      return Center(
        child: Text(state.errorMessage!),
      );
    }

    if (state.recipes.isEmpty) {
      return const Center(
        child: Text('No saved recipes'),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: state.recipes.length,
      separatorBuilder: (context, index) {
        return Divider(
          height: 3,
          thickness: 2,
          color: Colors.grey[350],
        );
      },
      itemBuilder: (context, index) {
        final recipe = state.recipes[index];

        return SavedAndSearchRecipeCard(
          recipeName: recipe.title,
          recipeImageUrl: recipe.imageUrl,
          recipeTime: recipe.cookMinutes,
          recipeCategory: recipe.category.toString(),
          isFavorite: recipe.isFavorite,
          onTapFavorite: () {
            _toggleFavorite(recipe.id);
          },
          isFavoriteLoading: ref
              .watch(favoriteProvider)
              .loadingIds
              .contains(recipe.id),
        );
      },
    );
  }
}
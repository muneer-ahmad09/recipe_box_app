import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/profile/saved/saved_recipe_controller.dart';

import 'profile_recipe_grid_card.dart';

class SavedTab extends ConsumerStatefulWidget {
  const SavedTab({super.key});

  @override
  ConsumerState<SavedTab> createState() => _SavedTabState();
}

class _SavedTabState extends ConsumerState<SavedTab> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(savedRecipeProvider.notifier).loadInitial();
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
          .read(savedRecipeProvider.notifier)
          .loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(savedRecipeProvider);

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

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      physics: const ClampingScrollPhysics(),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.recipes.length,
      itemBuilder: (context, index) {
        final recipe = state.recipes[index];

        return ProfileRecipeGridCard(
          recipeName: recipe.title,
          recipeImageUrl: recipe.imageUrl,
        );
      },
    );
  }
}
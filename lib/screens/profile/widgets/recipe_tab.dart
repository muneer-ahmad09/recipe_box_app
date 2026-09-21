import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/screens/profile/widgets/profile_recipe_grid_card.dart';

import '../../../core/features/profile/recipes/profile_recipe_controller.dart';

class RecipeTab extends ConsumerStatefulWidget {
  const RecipeTab({super.key});

  @override
  ConsumerState<RecipeTab> createState() => _RecipeTabState();

}

class _RecipeTabState  extends ConsumerState<RecipeTab>{
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    // Start loading before the user actually reaches
    // the absolute bottom.
    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(profileRecipeProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileRecipeProvider);

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Text(state.errorMessage!),
      );
    }

    if (state.recipes.isEmpty) {
      return const Center(
        child: Text('No recipes yet'),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.recipes.length + (state.isLoadingMore ? 2 : 0),itemBuilder: (context, index) {
      if (index >= state.recipes.length) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final recipe = state.recipes[index];

      return ProfileRecipeGridCard(
        recipeName: recipe.title,
        recipeImageUrl: recipe.imageUrl,
      );
    },
    );
  }
}
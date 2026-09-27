import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_box_app/core/features/favorites/favorite_controller.dart';
import 'package:recipe_box_app/core/features/recipe/recipe_controller.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_header.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_tab_content.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_tabs.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/write_review_sheet.dart';

import '../../core/features/reviews/review_controller.dart';

class RecipePage extends ConsumerStatefulWidget {
  final String id;
  final String? initialImageUrl;

  const RecipePage({super.key, required this.id, this.initialImageUrl});

  @override
  ConsumerState<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  String _selectedTab = 'Ingredients';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reviewProvider.notifier).reset();
      ref.read(recipeProvider.notifier).loadRecipe(widget.id);
    });
  }


  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      final reviewState = ref.read(reviewProvider);

      if (reviewState.hasMore &&
          !reviewState.isLoading &&
          !reviewState.isLoadingMore) {
        ref.read(reviewProvider.notifier).getReviews(
          recipeId: widget.id,
          page: reviewState.currentPage + 1,
        );
      }
    }
  }

  Future<void> _toggleFavorite() async {
    final result = await ref
        .read(favoriteProvider.notifier)
        .toggleFavorite(widget.id);

    if (result == null || !mounted) {
      return;
    }

    ref.read(recipeProvider.notifier).updateFavorite(result.isFavorite);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeState = ref.watch(recipeProvider);
    final reviewState = ref.watch(reviewProvider);

    if (recipeState.errorMessage != null) {
      return Scaffold(
        backgroundColor: AppColors.paper,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(recipeState.errorMessage!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(recipeProvider.notifier).loadRecipe(widget.id);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final recipe = recipeState.recipe;


    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
                SliverToBoxAdapter(
                  child: RecipeHeader(
                    initialImageUrl: widget.initialImageUrl,
                    recipeId: widget.id,
                    recipe: recipe,
                    onBack: () => Navigator.pop(context),
                    onFavorite: _toggleFavorite,
                  ),
                ),
              if (recipeState.recipe != null) ...[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: RecipeTabs(
                    selected: _selectedTab,
                    onChanged: (value) {
                      setState(() {
                        _selectedTab = value;
                      });
                      if (value == 'Reviews') {
                        ref.read(reviewProvider.notifier).getReviews(recipeId: widget.id);
                      }
                    },
                    topInset: MediaQuery.of(context).padding.top,
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                  sliver: SliverToBoxAdapter(
                    child: RecipeTabContent(
                      selectedTab: _selectedTab,
                      ingredients: recipe!.ingredients,
                      steps: recipe.steps,
                      reviews: reviewState.reviews,
                      onWriteReview: _showWriteReviewSheet,
                    ),
                  ),
                ),
              ] else ...[
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ],
          ),

          // _buildStartCookingButton(),
        ],
      ),
    );
  }

  // Widget _buildStartCookingButton() {
  //   return Positioned(
  //     left: 20,
  //     right: 20,
  //     bottom: 20,
  //     child: SizedBox(
  //       height: 50,
  //       child: ElevatedButton(
  //         onPressed: () {
  //           // TODO: Start cooking flow
  //         },
  //         style: ButtonStyle(
  //           backgroundColor: const WidgetStatePropertyAll(AppColors.petrol),
  //           shape: WidgetStatePropertyAll(
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           ),
  //         ),
  //         child: Text(
  //           'Start cooking',
  //           style: Theme.of(context).textTheme.bodyLarge
  //               ?.copyWith(color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showWriteReviewSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (sheetContext) {
        return Consumer(
          builder: (context, ref, child) {
            final reviewState = ref.watch(reviewProvider);

            return WriteReviewSheet(
              isSubmitting: reviewState.isSubmitting,
              errorMessage: reviewState.errorMessage,

              onSubmit: (rating, comment) async {
                await ref.read(reviewProvider.notifier).createReview(
                  recipeId: widget.id,
                  rating: rating,
                  comment: comment,
                );

                if (!context.mounted) {
                  return;
                }

                final state = ref.read(reviewProvider);

                if (state.isSuccess) {
                  Navigator.pop(sheetContext);

                  // Reset after successful submission.
                  ref.read(reviewProvider.notifier).reset();
                }
              },
            );
          },
        );
      },
    );
  }
}

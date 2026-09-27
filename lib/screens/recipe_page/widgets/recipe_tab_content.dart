import 'package:flutter/material.dart';

import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_check_box.dart';

import '../../../models/review.dart';
import '../../../widgets/review_card.dart';

class RecipeTabContent extends StatelessWidget {
  final String selectedTab;

  final List<String> ingredients;
  final List<String> steps;

  final List<Review> reviews;
  final VoidCallback onWriteReview;

  const RecipeTabContent({
    super.key,
    required this.selectedTab,
    required this.ingredients,
    required this.steps,
    required this.reviews,
    required this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedTab) {
      case 'Steps':
        return _buildSteps();

      case 'Reviews':
        return _buildReviews();

      case 'Ingredients':
      default:
        return _buildIngredients();
    }
  }

  // ------------------------------------------------------------------------
  // Ingredients
  // ------------------------------------------------------------------------

  Widget _buildIngredients() {
    if (ingredients.isEmpty) {
      return const Center(
        child: Text('No ingredients available'),
      );
    }

    return Column(
      children: ingredients.map((ingredient) {
        return RecipeCheckBox(
          ingredient: ingredient,
        );
      }).toList(),
    );
  }

  // ------------------------------------------------------------------------
  // Steps
  // ------------------------------------------------------------------------

  Widget _buildSteps() {
    if (steps.isEmpty) {
      return const Center(
        child: Text('No steps available'),
      );
    }

    return Column(
      children: List.generate(
        steps.length,
            (index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 18,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.petrol.withValues(
                    alpha: 0.1,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: AppColors.petrol,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    steps[index],
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------------------
  // Reviews
  // ------------------------------------------------------------------------

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${reviews.length} reviews',
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            GestureDetector(
              onTap: onWriteReview,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    size: 16,
                    color: AppColors.petrol,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Write a review',
                    style: TextStyle(
                      color: AppColors.petrol,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        if (reviews.isEmpty)
          const Text(
            'No reviews yet',
            style: TextStyle(
              color: AppColors.inkFaint,
              fontSize: 13,
            ),
          )
        else
          ...reviews.map(
                (review) => ReviewCard(review: review),
          ),
      ],
    );
  }
}


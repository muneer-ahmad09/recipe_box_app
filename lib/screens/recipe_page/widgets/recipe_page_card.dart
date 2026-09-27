import 'package:flutter/material.dart';

import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/models/recipe_detail.dart';
import 'package:recipe_box_app/widgets/dash_lines.dart';

class RecipePageCard extends StatelessWidget {
  final RecipeDetail? recipe;

  const RecipePageCard({
    super.key,
    this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          19,
          24,
          19,
          20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashLines(),

            const SizedBox(height: 12),

            // ----------------------------------------------------------
            // Recipe title
            // ----------------------------------------------------------
            Text(
              recipe!.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 27,
              ),
            ),

            // ----------------------------------------------------------
            // Author
            // ----------------------------------------------------------
            Text(
              'by ${recipe?.author.fullName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 14),

            // ----------------------------------------------------------
            // Recipe metadata
            // ----------------------------------------------------------
            Row(
              spacing: 13,
              children: [
                // Cooking time
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.mustard,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${recipe?.cookMinutes}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'min',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Rating + difficulty
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${recipe?.ratingAvg.toStringAsFixed(1)} rating',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.analytics_outlined,
                        ),
                        Text(
                          recipe!.difficulty.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
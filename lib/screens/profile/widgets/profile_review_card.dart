import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/profile_review.dart';

class ProfileReviewCard extends StatelessWidget {
  final ProfileReview review;

  const ProfileReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.paperDim),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecipeImage(),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRecipeTitle(),

                const SizedBox(height: 6),

                _buildRating(),

                const SizedBox(height: 6),

                Text(
                  review.comment,
                  style: const TextStyle(
                    color: AppColors.inkFaint,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  _formatDate(review.createdAt),
                  style: const TextStyle(
                    color: AppColors.inkFaint,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        review.recipeImageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 80,
            color: AppColors.paperDim,
            child: const Icon(Icons.restaurant, color: AppColors.inkFaint),
          );
        },
      ),
    );
  }

  Widget _buildRecipeTitle() {
    return Text(
      review.recipeTitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: AppColors.ink,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            Icons.star_rounded,
            size: 16,
            color: index < review.rating
                ? AppColors.mustard
                : AppColors.paperDim,
          );
        }),

        const SizedBox(width: 6),

        Text(
          '${review.rating}/5',
          style: const TextStyle(
            color: AppColors.inkFaint,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();

    return '${localDate.day.toString().padLeft(2, '0')}/'
        '${localDate.month.toString().padLeft(2, '0')}/'
        '${localDate.year}';
  }
}

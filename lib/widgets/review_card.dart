import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author.fullName,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Row(
                      children: List.generate(
                        5,
                            (index) {
                          return Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: index < review.rating
                                ? AppColors.mustard
                                : AppColors.paperDim,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      review.comment,
                      style: const TextStyle(
                        color: AppColors.inkFaint,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final avatarUrl = review.author.avatarUrl;

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(avatarUrl),
      );
    }

    return const CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.paperDim,
      child: Icon(
        Icons.person,
        color: AppColors.inkFaint,
      ),
    );
  }
}
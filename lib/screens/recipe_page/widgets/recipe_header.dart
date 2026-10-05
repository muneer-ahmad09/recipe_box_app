import 'package:flutter/material.dart';

import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/models/recipe_detail.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_page_card.dart';

class RecipeHeader extends StatelessWidget {
  final RecipeDetail? recipe;
  final String recipeId;
  final VoidCallback onBack;
  final VoidCallback onFavorite;
  final String? initialImageUrl;

  const RecipeHeader({
    super.key,
    this.recipe,
    required this.onBack,
    required this.onFavorite,
    this.initialImageUrl,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = initialImageUrl?.isNotEmpty == true
        ? initialImageUrl
        : recipe?.imageUrl;

    return SizedBox(
      height: 460,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --------------------------------------------------------------
          // Recipe image
          // --------------------------------------------------------------
          Hero(
            tag: 'recipe-image-$recipeId',
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : _buildPlaceholderImage(),
          ),

          // --------------------------------------------------------------
          // Back button
          // --------------------------------------------------------------
          Positioned(
            top: 48,
            left: 16,
            child: _CircleButton(icon: Icons.arrow_back, onTap: onBack),
          ),

          // --------------------------------------------------------------
          // Favorite button
          // --------------------------------------------------------------
          Positioned(
            top: 48,
            right: 16,
            child: _CircleButton(
              icon: recipe?.isFavorite == true
                  ? Icons.favorite
                  : Icons.favorite_border,
              iconColor: AppColors.clayberry,
              onTap: onFavorite,
            ),
          ),

          // --------------------------------------------------------------
          // Recipe information card
          // --------------------------------------------------------------
          if (recipe != null)
            Positioned(
              top: 260,
              left: 20,
              right: 20,
              child: RecipePageCard(recipe: recipe),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: const Icon(Icons.restaurant, size: 60, color: Colors.white),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.ink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 19,
        backgroundColor: AppColors.paper.withValues(alpha: 0.9),
        child: Icon(icon, color: iconColor, size: 19),
      ),
    );
  }
}

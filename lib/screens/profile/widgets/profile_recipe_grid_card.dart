import 'package:flutter/material.dart';

class ProfileRecipeGridCard extends StatelessWidget {
  final String recipeName;
  final String? recipeImageUrl;

  const ProfileRecipeGridCard({
    super.key,
    required this.recipeName,
    this.recipeImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _RecipeImage(
            imageUrl: recipeImageUrl,
          ),

          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),

          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Text(
              recipeName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeImage extends StatelessWidget {
  final String? imageUrl;

  const _RecipeImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return _ImagePlaceholder(
        icon: Icons.image_outlined,
      );
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,

      // Image couldn't be loaded.
      errorBuilder: (context, error, stackTrace) {
        return _ImagePlaceholder(
          icon: Icons.broken_image_outlined,
        );
      },

      // Optional: show a placeholder while loading.
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return _ImagePlaceholder(
          icon: Icons.image_outlined,
        );
      },
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final IconData icon;

  const _ImagePlaceholder({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 40,
        color: Colors.grey.shade500,
      ),
    );
  }
}
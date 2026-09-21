import 'package:flutter/material.dart';

class SavedAndSearchRecipeCard extends StatelessWidget {
  final String recipeName;
  final String? recipeImageUrl;
  final int recipeTime;
  final String recipeCategory;
  final VoidCallback? onTapFavorite;

  final bool isFavorite;
  final bool isFavoriteLoading;

  const SavedAndSearchRecipeCard({
    super.key,
    required this.recipeName,
    required this.recipeImageUrl,
    required this.recipeTime,
    required this.recipeCategory,
    required this.isFavorite,
    this.onTapFavorite,
    required this.isFavoriteLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 14.0,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------------
            // IMAGE
            // -------------------------
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: recipeImageUrl != null
                  ? Image.network(
                recipeImageUrl!,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.image),
            ),

            const SizedBox(width: 16),

            // -------------------------
            // DETAILS
            // -------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe name
                  Text(
                    recipeName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 4),

                  // Category
                  Text(
                    recipeCategory,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 2),

                  // Time
                  Text(
                    '$recipeTime mins',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),

            // -------------------------
            // FAVORITE
            // -------------------------
            const SizedBox(width: 8),

            isFavoriteLoading
                ? const SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
                : IconButton(
              onPressed: onTapFavorite,
              icon: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
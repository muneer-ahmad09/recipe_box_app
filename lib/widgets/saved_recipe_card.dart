import 'package:flutter/material.dart';

class SavedAndSearchRecipeCard extends StatelessWidget {
  final String recipeName;
  final String recipeImageUrl;
  final int recipeTime;
  final String recipeCategory;

  final bool showArrow;
  final bool showBookmark;
  final bool isBookmarked;

  const SavedAndSearchRecipeCard({
    super.key,
    required this.recipeName,
    required this.recipeImageUrl,
    required this.recipeTime,
    required this.recipeCategory,
    required this.showArrow,
    required this.showBookmark,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 25,
          children: [
            //image part
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(recipeImageUrl, fit: BoxFit.cover),
            ),
            //detail part
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipeName, style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      Text(
                        recipeCategory,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(" • ", style: Theme.of(context).textTheme.bodyLarge),
                      Text(
                        '${recipeTime.toString()} mins',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //icon part
            if(showArrow)
              Center(child: Icon(Icons.arrow_forward_ios)),
            if(showBookmark)
              Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
          ],
        ),
      ),
    );
  }
}

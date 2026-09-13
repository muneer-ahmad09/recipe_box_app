import 'package:flutter/material.dart';
import 'package:recipe_box_app/models/author.dart';
import 'package:recipe_box_app/models/recipe_enums.dart';
import 'package:recipe_box_app/widgets/dash_lines.dart';

import '../../../core/theme/app_colors.dart';

class HomePageRecipeCard extends StatelessWidget {
  final String id;
  final String title;
  final Author cookName;
  final String? imageUrl;
  final int cookMinutes;
  final double rating;
  final Difficulty level;

  const HomePageRecipeCard({
    super.key,
    required this.id,
    required this.title,
    required this.cookName,
    required this.rating,
    required this.level,
    this.imageUrl,
    required this.cookMinutes,
  });

  @override
  Widget build(BuildContext context) {
    final image = imageUrl;

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadiusGeometry.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DashLines(),
          ),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),

                // EDITED:
                // Added SizedBox with a fixed height.
                // Previously the Image had no explicit height, so its
                // size could contribute unpredictably to the card layout.
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Hero(
                      tag: "recipe-image-$id",
                      child: image == null
                          ? Image.asset(
                        "assets/images/vegeta.jpg",
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: -18,
                right: 1,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppColors.mustard,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$cookMinutes",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "min",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  title,

                  // EDITED:
                  // Limits the recipe title to two lines.
                  // This prevents a very long title from making the card
                  // much taller than expected.
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),

                Text(
                  'by ${cookName.fullName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(rating.toString()),

                    Container(
                      padding: const EdgeInsets.only(
                        right: 7.0,
                        left: 7.0,
                        top: 2.0,
                        bottom: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        difficultyEnumToString(level),
                        style: TextStyle(
                          color: Colors.green[300],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
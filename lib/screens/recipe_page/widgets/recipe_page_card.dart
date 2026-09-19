import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/widgets/dash_lines.dart';

/// Pure recipe info display — title, author, time, rating, difficulty.
/// No longer owns the Ingredients/Steps/Reviews toggle: that moved up
/// to RecipePage so it can live in a pinned sticky header and actually
/// control what's shown below it. This widget doesn't know or care
/// which tab is selected.
class RecipePageCard extends StatelessWidget {
  const RecipePageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // fills whatever the parent gives it — no fixed 340px to overflow on narrow phones
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadiusGeometry.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(19, 24, 19, 20), // top bumped 16->24: gives the title breathing room above the image seam
        child: Column(
          mainAxisSize: MainAxisSize.min, // size to content — no fixed height to overflow if the title wraps to 2 lines
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashLines(),
            const SizedBox(height: 12),
            Text(
              "Brown Butter Miso Cookies",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 27),
            ),
            Text("by Muneer Ahmad", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 14),
            Row(
              spacing: 13,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.mustard,
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("35", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                        Text("min", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4.8 rating", style: Theme.of(context).textTheme.bodyLarge),
                    Row(
                      children: [
                        const Icon(Icons.analytics_outlined),
                        Text("Easy", style: Theme.of(context).textTheme.bodyLarge),
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

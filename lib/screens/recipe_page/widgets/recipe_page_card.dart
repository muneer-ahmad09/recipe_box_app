import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_tab.dart';
import 'package:recipe_box_app/widgets/dash_lines.dart';

class RecipePageCard extends StatelessWidget{
  const RecipePageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 250,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadiusGeometry.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 5),
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.0),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashLines(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Heading"),
                Text("by Muneer Ahmad"),
              ],
            ),
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
                    Text(
                      "35",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "min",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4.8 rating"),
                    Row(
                      children: [
                        Icon(Icons.analytics_outlined),
                        Text("Easy")
                      ],
                    )
                  ],
                )
              ],
            ),
            RecipeTabs()
        
        
          ],
        ),
      ),
    );
  }
}
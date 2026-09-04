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
      height: 280,
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
        padding: EdgeInsetsGeometry.only(left:19.0,right:19.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: DashLines(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Brown Butter Miso Cookies",
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 27
                ),),
                Text("by Muneer Ahmad",style: Theme.of(context).textTheme.bodyLarge,),
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
                        color:Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "min",
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
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4.8 rating",style: Theme.of(context).textTheme.bodyLarge),
                    Row(
                      children: [
                        Icon(Icons.analytics_outlined),
                        Text("Easy",style: Theme.of(context).textTheme.bodyLarge)
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
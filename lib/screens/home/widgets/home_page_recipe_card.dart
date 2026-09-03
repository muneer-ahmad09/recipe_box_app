import 'package:flutter/material.dart';
import 'package:recipe_box_app/widgets/dash_lines.dart';

import '../../../core/theme/app_colors.dart';

class HomePageRecipeCard extends StatelessWidget {

  final int id;
  final String title;
  final String cookName;
  final double rating;
  final String level;

  const HomePageRecipeCard({
    super.key,
    required this.id,
    required this.title,
    required this.cookName,
    required this.rating,
    required this.level
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadiusGeometry.all(Radius.circular(25))
      ),
      child: Column(
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.all( 8.0),
            child: DashLines(),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0,right:8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Hero(
                    tag: "recipe-image-$id",
                    child: Image.asset(
                      'assets/images/vegeta.jpg',
                      fit: BoxFit.cover,
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
                      Text("35",style: TextStyle(
                        color: Colors.white
                      ),),
                      Text("min",style: TextStyle(
                          color: Colors.white
                      ),)
                    ],
                  )
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right:8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(title,
                  style:Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20
                  )),
                Text('by $cookName',
                style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(rating.toString()),
                    Container(
                      padding: const EdgeInsets.only(right:7.0,left:7.0,top:2.0,bottom: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadiusGeometry.all(Radius.circular(20))
                      ),
                        child: Text(level,
                        style: TextStyle(
                          color: Colors.green[300],
                          fontWeight: FontWeight.w500
                        ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

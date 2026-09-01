import 'package:flutter/material.dart';
import 'package:recipe_box_app/widgets/dash_lines.dart';

import '../../../core/theme/app_colors.dart';

class HomePageCard extends StatelessWidget {

  final String title;
  final String cookName;
  final double rating;
  final String level;

  const HomePageCard({
    super.key,
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
                  child: Image.asset(
                    'assets/images/vegeta.jpg',
                    fit: BoxFit.cover,
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
                  style:TextStyle(
                    fontSize: 20
                  ) ,),
                Text('by $cookName'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(rating.toString()),
                    Text(level)
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

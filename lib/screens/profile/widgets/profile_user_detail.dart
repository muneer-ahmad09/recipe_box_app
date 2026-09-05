import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/profile/widgets/stat.dart';

class ProfileUserDetail extends StatelessWidget {
  const ProfileUserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              // Profile picture
              const CircleAvatar(
                radius: 42,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              // User details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Muneer Ahmad',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      'Flutter Developer\n'
                          'React Native • FastAPI • Spring Boot\n'
                          'Building things that actually work 🚀',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.0
                      )
                    ),

                  ],

                )
              ),
            ],
          ),
          SizedBox(height: 25,),
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              borderRadius: BorderRadius.circular(18),
              border: BoxBorder.all(
                color: Colors.grey,
                width: 2,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stat(value: '5', label: 'Recipes',),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Stat(value: '1.2k', label: 'Followers'),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Stat(value: '340', label: 'Following'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
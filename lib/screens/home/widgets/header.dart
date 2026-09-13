import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/user.dart';

class Header extends StatelessWidget {
  final User user;

  const Header({super.key, required this.user});

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$greeting ${user.fullName}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.headingMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "What's in the pot tonight?",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const CircleAvatar(radius: 25),
          ),
        ],
      ),
    );
  }
}

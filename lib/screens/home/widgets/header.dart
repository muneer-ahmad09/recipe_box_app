import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

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
                  "Good Evening Sam",
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

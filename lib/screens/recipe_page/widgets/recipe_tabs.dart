import 'package:flutter/material.dart';

import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/widgets/options_tab.dart';

class RecipeTabs extends SliverPersistentHeaderDelegate {
  final String selected;
  final ValueChanged<String> onChanged;
  final double topInset;

  RecipeTabs({
    required this.selected,
    required this.onChanged,
    required this.topInset,
  });

  @override
  double get minExtent => 64 + topInset;

  @override
  double get maxExtent => 64 + topInset;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        topInset + 10,
        20,
        10,
      ),
      decoration: BoxDecoration(
        color: AppColors.paper,
        boxShadow: overlapsContent
            ? [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.06,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ]
            : null,
      ),
      child: OptionsTabs(
        options: const [
          "Ingredients",
          "Steps",
          "Reviews",
        ],
        changeValue: onChanged,
      ),
    );
  }

  @override
  bool shouldRebuild(
      covariant RecipeTabs oldDelegate,
      ) {
    return oldDelegate.selected != selected ||
        oldDelegate.topInset != topInset;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RecipeTabs extends StatefulWidget {
  const RecipeTabs({super.key});

  @override
  State<RecipeTabs> createState() => _RecipeTabsState();
}

class _RecipeTabsState extends State<RecipeTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? AppColors.cardWhite
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text("Ingredients"),
                ),
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? AppColors.cardWhite
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text("Steps"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
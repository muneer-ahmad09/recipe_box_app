import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/features/add_recipe/add_recipe_controller.dart';
import '../../../models/recipe_enums.dart';
import '../../../widgets/category_button.dart';

class AddItemDifficulty extends ConsumerWidget {
  const AddItemDifficulty({super.key});

  static const difficulties = [
    Difficulty.easy,
    Difficulty.medium,
    Difficulty.hard,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeState = ref.watch(addRecipeProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Difficulty",
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: difficulties.map((difficulty) {
              return CategoryButton(
                buttonName: difficultyEnumToString(difficulty),
                callback: () {
                  ref
                      .read(addRecipeProvider.notifier)
                      .updateDifficulty(difficulty);
                },
                isActive: recipeState.difficulty == difficulty,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

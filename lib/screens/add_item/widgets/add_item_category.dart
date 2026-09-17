import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/features/add_recipe/add_recipe_controller.dart';
import '../../../models/recipe_enums.dart';
import '../../../widgets/category_button.dart';

class AddItemCategory extends ConsumerWidget {
  const AddItemCategory({super.key});

  static const categories = [
    Category.breakfast,
    Category.lunch,
    Category.dinner,
    Category.dessert,
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
            "Category",
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: categories.map((category) {
              return CategoryButton(
                buttonName: categoryEnumToString(category),
                callback: () {
                  ref.read(addRecipeProvider.notifier).updateCategory(category);
                },
                isActive: recipeState.category == category,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }


}



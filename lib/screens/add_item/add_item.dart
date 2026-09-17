import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/screens/add_item/widgets/add_image.dart';
import 'package:recipe_box_app/screens/add_item/widgets/add_item_category.dart';
import 'package:recipe_box_app/screens/add_item/widgets/add_item_difficulty.dart';
import 'package:recipe_box_app/screens/add_item/widgets/cooking_time.dart';
import 'package:recipe_box_app/screens/add_item/widgets/ingredient.dart';
import 'package:recipe_box_app/screens/add_item/widgets/steps.dart';

import '../../core/features/add_recipe/add_recipe_controller.dart';

class AddItem extends ConsumerWidget {
  const AddItem({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 70),
      child: Column(
        spacing: 14,
        children: [
          AddImage(),
          //Recipe Text Field
          TextField(
            onChanged: (value) {
              ref.read(addRecipeProvider.notifier).updateTitle(value);
            },
            decoration: const InputDecoration(
              hintText: 'Recipe Name',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
          AddItemCategory(),
          AddItemDifficulty(),
          CookingTime(),
          Ingredient(),
          Steps(),
        ],
      ),
    );
  }

}



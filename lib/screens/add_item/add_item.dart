import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_box_app/screens/add_item/widgets/add_image.dart';
import 'package:recipe_box_app/screens/add_item/widgets/add_item_category.dart';
import 'package:recipe_box_app/screens/add_item/widgets/add_item_difficulty.dart';
import 'package:recipe_box_app/screens/add_item/widgets/cooking_time.dart';
import 'package:recipe_box_app/screens/add_item/widgets/ingredient.dart';
import 'package:recipe_box_app/screens/add_item/widgets/steps.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => AddItemState();
}

class AddItemState extends State<AddItem> {
  int cookingTime = 30;
  List<String> ingredients = [];
  List<String> steps = [];
  String? category;
  File? selectedImage;
  String? difficulty;
  final TextEditingController recipeTextController = TextEditingController();

  void saveRecipe() {
    print("Save button pressed");
  }

  @override
  void dispose() {
    recipeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 12, right: 12,top: 10,bottom: 70),
      child: Column(
        spacing: 14,
        children: [
           AddImage(onImageSelected: (image){
            setState(() {
                selectedImage = image;

            });
          }),
          //Recipe Text Field
          TextField(
            controller: recipeTextController,
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
          AddItemCategory(
            onCategoryChanged: (value) {
                category=value;
            },
          ),
          AddItemDifficulty(
            onDifficultyChanged: (value) {
              difficulty = value;
            },
          ),
          CookingTime(
            value: cookingTime,
            onChanged: (value) {
                cookingTime = value;
            },
          ),
          Ingredient(
            onIngredientsChanged: (newIngredients) {
              ingredients = newIngredients;
            },
          ),
          Steps(
            onStepsChanged: (newSteps) {
              steps = newSteps;
            },
          ),
        ],
      ),
    );
  }
}

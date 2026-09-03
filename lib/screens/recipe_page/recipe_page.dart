import 'package:flutter/material.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_check_box.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_page_card.dart';

class RecipePage extends StatefulWidget {
  final int id;

  const RecipePage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      top: true,
      bottom: true,
      left: false,
      right: false,
      minimum: EdgeInsets.zero,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Hero(
                  tag: 'recipe-image-${widget.id}',
                  child: Image.asset(
                    "assets/images/vegeta.jpg",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Reserve space for the overlapping card
              const SizedBox(height: 210),

              Expanded(
                flex: 4,
                child: SizedBox(
                  width: 340,
                  child: Column(
                    children: [
                      RecipeCheckBox(),
                      RecipeCheckBox(),
                      RecipeCheckBox(),
                      RecipeCheckBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: 160,
            left: 30,
            right: 30,
            child: RecipePageCard(),
          ),
        ],
      ),
    ),
    );
  }
}

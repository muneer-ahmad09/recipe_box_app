import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_check_box.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_page_card.dart';

class RecipePage extends StatelessWidget {
  final int id;

  static const List<Map<String, dynamic>> dummyData  = [
    {
      "id": 1,
      "ingredient": "Red Chilli",
    },
    {
      "id": 2,
      "ingredient": "Onion",
    },
    {
      "id": 3,
      "ingredient": "Garlic",
    },
    {
      "id": 4,
      "ingredient": "Ginger",
    },
    {
      "id": 5,
      "ingredient": "Tomato",
    },
    {
      "id": 6,
      "ingredient": "Potato",
    },
    {
      "id": 7,
      "ingredient": "Green Chilli",
    },
    {
      "id": 8,
      "ingredient": "Cumin Seeds",
    },
    {
      "id": 9,
      "ingredient": "Coriander Powder",
    },
    {
      "id": 10,
      "ingredient": "Turmeric Powder",
    },
    {
      "id": 11,
      "ingredient": "Garam Masala",
    },
    {
      "id": 12,
      "ingredient": "Black Pepper",
    },
    {
      "id": 13,
      "ingredient": "Cinnamon",
    },
    {
      "id": 14,
      "ingredient": "Cardamom",
    },
    {
      "id": 15,
      "ingredient": "Cloves",
    },
    {
      "id": 16,
      "ingredient": "Mustard Seeds",
    },
    {
      "id": 17,
      "ingredient": "Curry Leaves",
    },
    {
      "id": 18,
      "ingredient": "Fresh Coriander",
    },
    {
      "id": 19,
      "ingredient": "Lemon",
    },
    {
      "id": 20,
      "ingredient": "Salt",
    },
  ];

  const RecipePage({super.key, required this.id});

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
                flex: 3,
                child: Hero(
                  tag: 'recipe-image-$id',
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
                flex: 5,
                child: SizedBox(
                  width: 340,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: dummyData.map((value)
                        {
                          return RecipeCheckBox(ingredient: value["ingredient"]);
                        }
                        ).toList(),

                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top:15.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    fixedSize: const WidgetStatePropertyAll(
                      Size(200, 50)
                    ),
                    backgroundColor: WidgetStatePropertyAll(AppColors.petrol),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Text(
                    "Start",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),

          Positioned(
            top: 135,
            left: 30,
            right: 30,
            child: RecipePageCard(),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop((context));
            },
            icon: const Icon(Icons.arrow_back),
            style: ButtonStyle(
              foregroundColor: const WidgetStatePropertyAll(
                Colors.white,
              ),
              backgroundColor: const WidgetStatePropertyAll(
                Colors.white38,
              ),
            ),
          ),

        ],

      ),
    ),
    );
  }
}

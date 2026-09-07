import 'package:flutter/material.dart';
import 'package:recipe_box_app/screens/bookmark/widgets/saved_recipe_card.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  static final List<Map<String, dynamic>> dummyRecipes = [
    {
      "recipeName": "Butter Chicken",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398",
      "recipeTime": 45,
      "recipeCategory": "Dinner",
    },
    {
      "recipeName": "Pancakes",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1528207776546-365bb710ee93",
      "recipeTime": 20,
      "recipeCategory": "Breakfast",
    },
    {
      "recipeName": "Margherita Pizza",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002",
      "recipeTime": 30,
      "recipeCategory": "Dinner",
    },
    {
      "recipeName": "Pasta Carbonara",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1473093295043-cdd812d0e601",
      "recipeTime": 25,
      "recipeCategory": "Dinner",
    },
    {
      "recipeName": "Caesar Salad",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1550304943-4f24f54ddde9",
      "recipeTime": 15,
      "recipeCategory": "Lunch",
    },
    {
      "recipeName": "Chocolate Cake",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1578985545062-69928b1d9587",
      "recipeTime": 50,
      "recipeCategory": "Dessert",
    },
    {
      "recipeName": "Grilled Chicken",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1532550907401-a500c9a57435",
      "recipeTime": 35,
      "recipeCategory": "Dinner",
    },
    {
      "recipeName": "French Toast",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1484723091739-30a097e8f929",
      "recipeTime": 15,
      "recipeCategory": "Breakfast",
    },
    {
      "recipeName": "Chicken Tikka",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0",
      "recipeTime": 40,
      "recipeCategory": "Dinner",
    },
    {
      "recipeName": "Mango Cheesecake",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1565958011703-44f9829ba187",
      "recipeTime": 45,
      "recipeCategory": "Dessert",
    },
    {
      "recipeName": "Vegetable Stir Fry",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1512621776951-a57141f2eefd",
      "recipeTime": 20,
      "recipeCategory": "Lunch",
    },
    {
      "recipeName": "Masala Dosa",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1589301760014-d929f3979dbc",
      "recipeTime": 35,
      "recipeCategory": "Breakfast",
    },
    {
      "recipeName": "Tandoori Chicken",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1598515214211-89d3c73ae83b",
      "recipeTime": 55,
      "recipeCategory": "Dinner",
    },
    {
      "recipeName": "Fruit Bowl",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea",
      "recipeTime": 10,
      "recipeCategory": "Breakfast",
    },
    {
      "recipeName": "Paneer Butter Masala",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1631452180519-c014fe946bc7",
      "recipeTime": 40,
      "recipeCategory": "Dinner",
    },
    {
      "recipeName": "Samosa",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1601050690597-df0568f70950",
      "recipeTime": 30,
      "recipeCategory": "Lunch",
    },
    {
      "recipeName": "Red Velvet Cake",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1586788680434-30d324b2d46f",
      "recipeTime": 55,
      "recipeCategory": "Dessert",
    },
    {
      "recipeName": "Chole Bhature",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1626132647523-66f5bf380027",
      "recipeTime": 45,
      "recipeCategory": "Lunch",
    },
    {
      "recipeName": "Aloo Paratha",
      "recipeImageUrl":
          "https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7",
      "recipeTime": 30,
      "recipeCategory": "Breakfast",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),

      itemBuilder: (BuildContext context, int index) {
        return SavedRecipeCard(
          recipeName: dummyRecipes[index]["recipeName"],
          recipeImageUrl: dummyRecipes[index]["recipeImageUrl"],
          recipeTime: dummyRecipes[index]["recipeTime"],
          recipeCategory: dummyRecipes[index]["recipeCategory"],
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 3, thickness: 2, color: Colors.grey[350]
          ),
      itemCount: dummyRecipes.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_box_app/screens/profile/widgets/profile_recipe_grid_card.dart';

class RecipeTab extends StatelessWidget {
  const RecipeTab({super.key});

  static const List<Map<String,dynamic>> dummyRecipes = [
    {
      "id": 1,
      "name": "Butter Chicken",
      "imageUrl": "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398",
    },
    {
      "id": 3,
      "name": "Paneer Tikka",
      "imageUrl": "https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8",
    },
    {
      "id": 4,
      "name": "Masala Dosa",
      "imageUrl": "https://images.unsplash.com/photo-1668236543090-82eba5ee5976",
    },
    {
      "id": 5,
      "name": "Chole Bhature",
      "imageUrl": "https://images.unsplash.com/photo-1626132647523-66f5bf380027",
    },
    {
      "id": 6,
      "name": "Palak Paneer",
      "imageUrl": "https://images.unsplash.com/photo-1601050690597-df0568f70950",
    },
    {
      "id": 7,
      "name": "Tandoori Chicken",
      "imageUrl": "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0",
    },
    {
      "id": 8,
      "name": "Rajma Masala",
      "imageUrl": "https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7",
    },
    {
      "id": 9,
      "name": "Aloo Gobi",
      "imageUrl": "https://images.unsplash.com/photo-1601050690597-df0568f70950",
    },
    {
      "id": 10,
      "name": "Dal Makhani",
      "imageUrl": "https://images.unsplash.com/photo-1546833999-b9f581a1996d",
    },
    {
      "id": 11,
      "name": "Matar Paneer",
      "imageUrl": "https://images.unsplash.com/photo-1631452180519-c014fe946bc7",
    },
    {
      "id": 12,
      "name": "Chicken Korma",
      "imageUrl": "https://images.unsplash.com/photo-1588166524941-3bf61a9c41db",
    },
    {
      "id": 13,
      "name": "Veg Pulao",
      "imageUrl": "https://images.unsplash.com/photo-1596797038530-2c107229654b",
    },
    {
      "id": 14,
      "name": "Samosa",
      "imageUrl": "https://images.unsplash.com/photo-1601050690597-df0568f70950",
    },
    {
      "id": 15,
      "name": "Pav Bhaji",
      "imageUrl": "https://images.unsplash.com/photo-1606491956689-2ea866880c84",
    },
    {
      "id": 16,
      "name": "Malai Kofta",
      "imageUrl": "https://images.unsplash.com/photo-1631452180519-c014fe946bc7",
    },
    {
      "id": 17,
      "name": "Chicken Tikka",
      "imageUrl": "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0",
    },
    {
      "id": 18,
      "name": "Vegetable Curry",
      "imageUrl": "https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7",
    },

    {
      "id": 20,
      "name": "Mango Lassi",
      "imageUrl": "https://images.unsplash.com/photo-1546173159-315724a31696",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: dummyRecipes.length,
      itemBuilder: (context, index) {
        final recipe = dummyRecipes[index];
        return ProfileRecipeGridCard(recipeName: recipe["name"], recipeImageUrl: recipe["imageUrl"],);
      },
    );
  }
}
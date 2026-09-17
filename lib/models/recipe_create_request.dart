import 'package:recipe_box_app/models/recipe_enums.dart';

class RecipeCreateRequest {
  final String title;
  final String? imageUrl;
  final int cookMinutes;
  final Difficulty difficulty;
  final Category category;
  final List<String> ingredients;
  final List<String> steps;

  const RecipeCreateRequest({
    required this.title,
    this.imageUrl,
    required this.cookMinutes,
    required this.difficulty,
    required this.category,
    required this.ingredients,
    required this.steps,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image_url': imageUrl,
      'cook_minutes': cookMinutes,
      'difficulty': difficultyEnumToString(difficulty),
      'category': categoryEnumToString(category),
      'ingredients': ingredients,
      'steps': steps,
    };
  }
}
import 'package:recipe_box_app/models/recipe_enums.dart';

import 'user.dart';

class RecipeDetail {
  final String id;
  final String title;
  final String? imageUrl;
  final int cookMinutes;
  final Difficulty difficulty;
  final Category category;
  final double ratingAvg;
  final int ratingCount;
  final User author;
  final bool isFavorite;
  final List<String> ingredients;
  final List<String> steps;
  final DateTime createdAt;

  const RecipeDetail({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.cookMinutes,
    required this.difficulty,
    required this.category,
    required this.ratingAvg,
    required this.ratingCount,
    required this.author,
    required this.isFavorite,
    required this.ingredients,
    required this.steps,
    required this.createdAt,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      cookMinutes: json['cook_minutes'],
      difficulty: convertApiDifficultyToEnum(json['difficulty']),
      category: convertApiCategoryToEnum(json['category']),
      ratingAvg: (json['rating_avg'] as num).toDouble(),
      ratingCount: json['rating_count'],
      author: User.fromJson(json['author']),
      isFavorite: json['is_favorite'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
import 'package:recipe_box_app/models/recipe_enums.dart';

import 'author.dart';

class RecipeCard {
  final String id;
  final String title;
  final String? imageUrl;
  final int cookMinutes;
  final Difficulty difficulty;
  final Category category;
  final Author author;
  final double ratingAvg;
  final int ratingCount;
  final bool isFavorite;

  const RecipeCard({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.cookMinutes,
    required this.difficulty,
    required this.category,
    required this.author,
    required this.ratingAvg,
    required this.ratingCount,
    required this.isFavorite,
  });

  factory RecipeCard.fromJson(Map<String, dynamic> json) {
    return RecipeCard(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      cookMinutes: json['cook_minutes'],
      difficulty: convertApiDifficultyToEnum(json['difficulty']),
      category: convertApiCategoryToEnum(json['category']),
      author: Author.fromJson(json['author']),
      ratingAvg: json['rating_avg'],
      ratingCount: json['rating_count'],
      isFavorite: json['is_favorite'],
    );
  }

  RecipeCard copyWith({bool? isFavorite}) {
    return RecipeCard(
      id: id,
      title: title,
      imageUrl: imageUrl,
      cookMinutes: cookMinutes,
      difficulty: difficulty,
      category: category,
      author: author,
      ratingAvg: ratingAvg,
      ratingCount: ratingCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

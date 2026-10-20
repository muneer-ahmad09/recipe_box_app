
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'dart:convert';
import 'package:recipe_box_app/models/recipe_enums.dart';

import 'package:recipe_box_app/models/recipe_card.dart';

import '../../models/author.dart';
import 'tables/cached_recipes.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CachedRecipes,
  ],
)
class AppDatabase extends _$AppDatabase {
  // AppDatabase() : super(_openConnection());

  AppDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  // Future<void> saveRecipe(RecipeCard recipe) async {
  //   await into(cachedRecipes).insertOnConflictUpdate(
  //     CachedRecipesCompanion.insert(
  //       id: recipe.id,
  //       title: recipe.title,
  //       imageUrl: Value(recipe.imageUrl),
  //       cookMinutes: recipe.cookMinutes,
  //       difficulty: difficultyEnumToString(recipe.difficulty),
  //       category: categoryEnumToString(recipe.category),
  //       authorJson: jsonEncode(recipe.author.toJson()),
  //       ratingAvg: recipe.ratingAvg,
  //       ratingCount: recipe.ratingCount,
  //       isFavorite: recipe.isFavorite,
  //       cachedAt: DateTime.now(),
  //     ),
  //   );
  // }

  Future<void> saveRecipe(RecipeCard recipe) {
    return saveRecipes([recipe]);
  }

  Future<void> saveRecipes(List<RecipeCard> recipes) async {
    await transaction(() async {
      for (final recipe in recipes) {
        await into(cachedRecipes).insertOnConflictUpdate(
          CachedRecipesCompanion.insert(
            id: recipe.id,
            title: recipe.title,
            imageUrl: Value(recipe.imageUrl),
            cookMinutes: recipe.cookMinutes,
            difficulty: difficultyEnumToString(recipe.difficulty),
            category: categoryEnumToString(recipe.category),
            authorJson: jsonEncode(recipe.author.toJson()),
            ratingAvg: recipe.ratingAvg,
            ratingCount: recipe.ratingCount,
            isFavorite: recipe.isFavorite,
            cachedAt: DateTime.now(),
          ),
        );
      }
    });
  }

  Future<List<RecipeCard>> getCachedRecipes() async {
    final rows = await select(cachedRecipes).get();

    return rows.map((row) {
      final authorJson =
      jsonDecode(row.authorJson) as Map<String, dynamic>;

      return RecipeCard(
        id: row.id,
        title: row.title,
        imageUrl: row.imageUrl,
        cookMinutes: row.cookMinutes,
        difficulty: convertApiDifficultyToEnum(row.difficulty),
        category: convertApiCategoryToEnum(row.category),
        author: Author.fromJson(authorJson),
        ratingAvg: row.ratingAvg,
        ratingCount: row.ratingCount,
        isFavorite: row.isFavorite,
      );
    }).toList();
  }


  Future<int> countCachedRecipes() {
    return select(cachedRecipes).get().then((rows) => rows.length);
  }

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'recipe_box_database',
  );
}

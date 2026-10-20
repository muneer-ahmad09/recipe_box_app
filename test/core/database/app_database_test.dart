import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_box_app/core/database/app_database.dart';
import 'package:recipe_box_app/models/author.dart';
import 'package:recipe_box_app/models/recipe_card.dart';
import 'package:recipe_box_app/models/recipe_enums.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('starts with an empty recipe cache', () async {
    final count = await database.countCachedRecipes();

    expect(count, 0);
  });

  test('saves a recipe and retrieves it correctly', () async {
    // Arrange: create a sample recipe.
    const recipe = RecipeCard(
      id: 'recipe-001',
      title: 'Chocolate Cake',
      imageUrl: 'https://example.com/cake.jpg',
      cookMinutes: 45,
      difficulty: Difficulty.medium,
      category: Category.dessert,
      author: Author(
        id: 'author-001',
        fullName: 'Ayesha Khan',
        avatarUrl: 'https://example.com/ayesha.jpg',
      ),
      ratingAvg: 4.5,
      ratingCount: 120,
      isFavorite: true,
    );

    // Act: save the recipe and read it back.
    await database.saveRecipe(recipe);

    final cachedRecipes = await database.getCachedRecipes();

    // Assert: verify that the recipe was saved correctly.
    expect(cachedRecipes, hasLength(1));

    final cachedRecipe = cachedRecipes.first;

    expect(cachedRecipe.id, recipe.id);
    expect(cachedRecipe.title, recipe.title);
    expect(cachedRecipe.imageUrl, recipe.imageUrl);
    expect(cachedRecipe.cookMinutes, recipe.cookMinutes);
    expect(cachedRecipe.difficulty, recipe.difficulty);
    expect(cachedRecipe.category, recipe.category);

    expect(cachedRecipe.author.id, recipe.author.id);
    expect(cachedRecipe.author.fullName, recipe.author.fullName);
    expect(cachedRecipe.author.avatarUrl, recipe.author.avatarUrl);

    expect(cachedRecipe.ratingAvg, recipe.ratingAvg);
    expect(cachedRecipe.ratingCount, recipe.ratingCount);
    expect(cachedRecipe.isFavorite, recipe.isFavorite);
  });

  test('updates an existing recipe instead of creating a duplicate', () async {
    const originalRecipe = RecipeCard(
      id: 'recipe-001',
      title: 'Chocolate Cake',
      cookMinutes: 45,
      difficulty: Difficulty.medium,
      category: Category.dessert,
      author: Author(
        id: 'author-001',
        fullName: 'Ayesha Khan',
      ),
      ratingAvg: 4.5,
      ratingCount: 120,
      isFavorite: false,
    );

    final updatedRecipe = originalRecipe.copyWith(isFavorite: true);

    await database.saveRecipe(originalRecipe);
    await database.saveRecipe(updatedRecipe);

    final cachedRecipes = await database.getCachedRecipes();

    expect(cachedRecipes, hasLength(1));
    expect(cachedRecipes.single.id, 'recipe-001');
    expect(cachedRecipes.single.isFavorite, isTrue);
  });
}
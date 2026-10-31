import 'package:drift/drift.dart';

import 'cached_recipes.dart';

class CachedRecipeFeedEntries extends Table {
  TextColumn get feedKey => text()();

  TextColumn get recipeId =>
      text().references(CachedRecipes, #id)();

  IntColumn get page => integer()();

  IntColumn get position => integer()();

  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {
    feedKey,
    page,
    position,
  };
}
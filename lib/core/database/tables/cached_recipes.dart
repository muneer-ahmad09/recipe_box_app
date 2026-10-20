
import 'package:drift/drift.dart';

class CachedRecipes extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get imageUrl => text().nullable()();

  IntColumn get cookMinutes => integer()();

  TextColumn get difficulty => text()();

  TextColumn get category => text()();

  TextColumn get authorJson => text()();

  RealColumn get ratingAvg => real()();

  IntColumn get ratingCount => integer()();

  BoolColumn get isFavorite => boolean()();

  DateTimeColumn get cachedAt => dateTime()();


  @override
  Set<Column> get primaryKey => {id};
}

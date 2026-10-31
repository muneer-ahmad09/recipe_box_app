// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedRecipesTable extends CachedRecipes
    with TableInfo<$CachedRecipesTable, CachedRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cookMinutesMeta = const VerificationMeta(
    'cookMinutes',
  );
  @override
  late final GeneratedColumn<int> cookMinutes = GeneratedColumn<int>(
    'cook_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorJsonMeta = const VerificationMeta(
    'authorJson',
  );
  @override
  late final GeneratedColumn<String> authorJson = GeneratedColumn<String>(
    'author_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingAvgMeta = const VerificationMeta(
    'ratingAvg',
  );
  @override
  late final GeneratedColumn<double> ratingAvg = GeneratedColumn<double>(
    'rating_avg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingCountMeta = const VerificationMeta(
    'ratingCount',
  );
  @override
  late final GeneratedColumn<int> ratingCount = GeneratedColumn<int>(
    'rating_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    imageUrl,
    cookMinutes,
    difficulty,
    category,
    authorJson,
    ratingAvg,
    ratingCount,
    isFavorite,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedRecipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('cook_minutes')) {
      context.handle(
        _cookMinutesMeta,
        cookMinutes.isAcceptableOrUnknown(
          data['cook_minutes']!,
          _cookMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cookMinutesMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('author_json')) {
      context.handle(
        _authorJsonMeta,
        authorJson.isAcceptableOrUnknown(data['author_json']!, _authorJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_authorJsonMeta);
    }
    if (data.containsKey('rating_avg')) {
      context.handle(
        _ratingAvgMeta,
        ratingAvg.isAcceptableOrUnknown(data['rating_avg']!, _ratingAvgMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingAvgMeta);
    }
    if (data.containsKey('rating_count')) {
      context.handle(
        _ratingCountMeta,
        ratingCount.isAcceptableOrUnknown(
          data['rating_count']!,
          _ratingCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ratingCountMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedRecipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedRecipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      cookMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_minutes'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      authorJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_json'],
      )!,
      ratingAvg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating_avg'],
      )!,
      ratingCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating_count'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedRecipesTable createAlias(String alias) {
    return $CachedRecipesTable(attachedDatabase, alias);
  }
}

class CachedRecipe extends DataClass implements Insertable<CachedRecipe> {
  final String id;
  final String title;
  final String? imageUrl;
  final int cookMinutes;
  final String difficulty;
  final String category;
  final String authorJson;
  final double ratingAvg;
  final int ratingCount;
  final bool isFavorite;
  final DateTime cachedAt;
  const CachedRecipe({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.cookMinutes,
    required this.difficulty,
    required this.category,
    required this.authorJson,
    required this.ratingAvg,
    required this.ratingCount,
    required this.isFavorite,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['cook_minutes'] = Variable<int>(cookMinutes);
    map['difficulty'] = Variable<String>(difficulty);
    map['category'] = Variable<String>(category);
    map['author_json'] = Variable<String>(authorJson);
    map['rating_avg'] = Variable<double>(ratingAvg);
    map['rating_count'] = Variable<int>(ratingCount);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedRecipesCompanion toCompanion(bool nullToAbsent) {
    return CachedRecipesCompanion(
      id: Value(id),
      title: Value(title),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      cookMinutes: Value(cookMinutes),
      difficulty: Value(difficulty),
      category: Value(category),
      authorJson: Value(authorJson),
      ratingAvg: Value(ratingAvg),
      ratingCount: Value(ratingCount),
      isFavorite: Value(isFavorite),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedRecipe(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      cookMinutes: serializer.fromJson<int>(json['cookMinutes']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      category: serializer.fromJson<String>(json['category']),
      authorJson: serializer.fromJson<String>(json['authorJson']),
      ratingAvg: serializer.fromJson<double>(json['ratingAvg']),
      ratingCount: serializer.fromJson<int>(json['ratingCount']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'cookMinutes': serializer.toJson<int>(cookMinutes),
      'difficulty': serializer.toJson<String>(difficulty),
      'category': serializer.toJson<String>(category),
      'authorJson': serializer.toJson<String>(authorJson),
      'ratingAvg': serializer.toJson<double>(ratingAvg),
      'ratingCount': serializer.toJson<int>(ratingCount),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedRecipe copyWith({
    String? id,
    String? title,
    Value<String?> imageUrl = const Value.absent(),
    int? cookMinutes,
    String? difficulty,
    String? category,
    String? authorJson,
    double? ratingAvg,
    int? ratingCount,
    bool? isFavorite,
    DateTime? cachedAt,
  }) => CachedRecipe(
    id: id ?? this.id,
    title: title ?? this.title,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    cookMinutes: cookMinutes ?? this.cookMinutes,
    difficulty: difficulty ?? this.difficulty,
    category: category ?? this.category,
    authorJson: authorJson ?? this.authorJson,
    ratingAvg: ratingAvg ?? this.ratingAvg,
    ratingCount: ratingCount ?? this.ratingCount,
    isFavorite: isFavorite ?? this.isFavorite,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedRecipe copyWithCompanion(CachedRecipesCompanion data) {
    return CachedRecipe(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      cookMinutes: data.cookMinutes.present
          ? data.cookMinutes.value
          : this.cookMinutes,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      category: data.category.present ? data.category.value : this.category,
      authorJson: data.authorJson.present
          ? data.authorJson.value
          : this.authorJson,
      ratingAvg: data.ratingAvg.present ? data.ratingAvg.value : this.ratingAvg,
      ratingCount: data.ratingCount.present
          ? data.ratingCount.value
          : this.ratingCount,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipe(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('cookMinutes: $cookMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('category: $category, ')
          ..write('authorJson: $authorJson, ')
          ..write('ratingAvg: $ratingAvg, ')
          ..write('ratingCount: $ratingCount, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    imageUrl,
    cookMinutes,
    difficulty,
    category,
    authorJson,
    ratingAvg,
    ratingCount,
    isFavorite,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedRecipe &&
          other.id == this.id &&
          other.title == this.title &&
          other.imageUrl == this.imageUrl &&
          other.cookMinutes == this.cookMinutes &&
          other.difficulty == this.difficulty &&
          other.category == this.category &&
          other.authorJson == this.authorJson &&
          other.ratingAvg == this.ratingAvg &&
          other.ratingCount == this.ratingCount &&
          other.isFavorite == this.isFavorite &&
          other.cachedAt == this.cachedAt);
}

class CachedRecipesCompanion extends UpdateCompanion<CachedRecipe> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> imageUrl;
  final Value<int> cookMinutes;
  final Value<String> difficulty;
  final Value<String> category;
  final Value<String> authorJson;
  final Value<double> ratingAvg;
  final Value<int> ratingCount;
  final Value<bool> isFavorite;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedRecipesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.cookMinutes = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.category = const Value.absent(),
    this.authorJson = const Value.absent(),
    this.ratingAvg = const Value.absent(),
    this.ratingCount = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedRecipesCompanion.insert({
    required String id,
    required String title,
    this.imageUrl = const Value.absent(),
    required int cookMinutes,
    required String difficulty,
    required String category,
    required String authorJson,
    required double ratingAvg,
    required int ratingCount,
    required bool isFavorite,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       cookMinutes = Value(cookMinutes),
       difficulty = Value(difficulty),
       category = Value(category),
       authorJson = Value(authorJson),
       ratingAvg = Value(ratingAvg),
       ratingCount = Value(ratingCount),
       isFavorite = Value(isFavorite),
       cachedAt = Value(cachedAt);
  static Insertable<CachedRecipe> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? imageUrl,
    Expression<int>? cookMinutes,
    Expression<String>? difficulty,
    Expression<String>? category,
    Expression<String>? authorJson,
    Expression<double>? ratingAvg,
    Expression<int>? ratingCount,
    Expression<bool>? isFavorite,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (imageUrl != null) 'image_url': imageUrl,
      if (cookMinutes != null) 'cook_minutes': cookMinutes,
      if (difficulty != null) 'difficulty': difficulty,
      if (category != null) 'category': category,
      if (authorJson != null) 'author_json': authorJson,
      if (ratingAvg != null) 'rating_avg': ratingAvg,
      if (ratingCount != null) 'rating_count': ratingCount,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedRecipesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? imageUrl,
    Value<int>? cookMinutes,
    Value<String>? difficulty,
    Value<String>? category,
    Value<String>? authorJson,
    Value<double>? ratingAvg,
    Value<int>? ratingCount,
    Value<bool>? isFavorite,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedRecipesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      cookMinutes: cookMinutes ?? this.cookMinutes,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      authorJson: authorJson ?? this.authorJson,
      ratingAvg: ratingAvg ?? this.ratingAvg,
      ratingCount: ratingCount ?? this.ratingCount,
      isFavorite: isFavorite ?? this.isFavorite,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (cookMinutes.present) {
      map['cook_minutes'] = Variable<int>(cookMinutes.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (authorJson.present) {
      map['author_json'] = Variable<String>(authorJson.value);
    }
    if (ratingAvg.present) {
      map['rating_avg'] = Variable<double>(ratingAvg.value);
    }
    if (ratingCount.present) {
      map['rating_count'] = Variable<int>(ratingCount.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('cookMinutes: $cookMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('category: $category, ')
          ..write('authorJson: $authorJson, ')
          ..write('ratingAvg: $ratingAvg, ')
          ..write('ratingCount: $ratingCount, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedRecipeFeedEntriesTable extends CachedRecipeFeedEntries
    with TableInfo<$CachedRecipeFeedEntriesTable, CachedRecipeFeedEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedRecipeFeedEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _feedKeyMeta = const VerificationMeta(
    'feedKey',
  );
  @override
  late final GeneratedColumn<String> feedKey = GeneratedColumn<String>(
    'feed_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cached_recipes (id)',
    ),
  );
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    feedKey,
    recipeId,
    page,
    position,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_recipe_feed_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedRecipeFeedEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('feed_key')) {
      context.handle(
        _feedKeyMeta,
        feedKey.isAcceptableOrUnknown(data['feed_key']!, _feedKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_feedKeyMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {feedKey, page, position};
  @override
  CachedRecipeFeedEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedRecipeFeedEntry(
      feedKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feed_key'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedRecipeFeedEntriesTable createAlias(String alias) {
    return $CachedRecipeFeedEntriesTable(attachedDatabase, alias);
  }
}

class CachedRecipeFeedEntry extends DataClass
    implements Insertable<CachedRecipeFeedEntry> {
  final String feedKey;
  final String recipeId;
  final int page;
  final int position;
  final DateTime cachedAt;
  const CachedRecipeFeedEntry({
    required this.feedKey,
    required this.recipeId,
    required this.page,
    required this.position,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['feed_key'] = Variable<String>(feedKey);
    map['recipe_id'] = Variable<String>(recipeId);
    map['page'] = Variable<int>(page);
    map['position'] = Variable<int>(position);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedRecipeFeedEntriesCompanion toCompanion(bool nullToAbsent) {
    return CachedRecipeFeedEntriesCompanion(
      feedKey: Value(feedKey),
      recipeId: Value(recipeId),
      page: Value(page),
      position: Value(position),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedRecipeFeedEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedRecipeFeedEntry(
      feedKey: serializer.fromJson<String>(json['feedKey']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      page: serializer.fromJson<int>(json['page']),
      position: serializer.fromJson<int>(json['position']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'feedKey': serializer.toJson<String>(feedKey),
      'recipeId': serializer.toJson<String>(recipeId),
      'page': serializer.toJson<int>(page),
      'position': serializer.toJson<int>(position),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedRecipeFeedEntry copyWith({
    String? feedKey,
    String? recipeId,
    int? page,
    int? position,
    DateTime? cachedAt,
  }) => CachedRecipeFeedEntry(
    feedKey: feedKey ?? this.feedKey,
    recipeId: recipeId ?? this.recipeId,
    page: page ?? this.page,
    position: position ?? this.position,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedRecipeFeedEntry copyWithCompanion(
    CachedRecipeFeedEntriesCompanion data,
  ) {
    return CachedRecipeFeedEntry(
      feedKey: data.feedKey.present ? data.feedKey.value : this.feedKey,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      page: data.page.present ? data.page.value : this.page,
      position: data.position.present ? data.position.value : this.position,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipeFeedEntry(')
          ..write('feedKey: $feedKey, ')
          ..write('recipeId: $recipeId, ')
          ..write('page: $page, ')
          ..write('position: $position, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(feedKey, recipeId, page, position, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedRecipeFeedEntry &&
          other.feedKey == this.feedKey &&
          other.recipeId == this.recipeId &&
          other.page == this.page &&
          other.position == this.position &&
          other.cachedAt == this.cachedAt);
}

class CachedRecipeFeedEntriesCompanion
    extends UpdateCompanion<CachedRecipeFeedEntry> {
  final Value<String> feedKey;
  final Value<String> recipeId;
  final Value<int> page;
  final Value<int> position;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedRecipeFeedEntriesCompanion({
    this.feedKey = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.page = const Value.absent(),
    this.position = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedRecipeFeedEntriesCompanion.insert({
    required String feedKey,
    required String recipeId,
    required int page,
    required int position,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : feedKey = Value(feedKey),
       recipeId = Value(recipeId),
       page = Value(page),
       position = Value(position),
       cachedAt = Value(cachedAt);
  static Insertable<CachedRecipeFeedEntry> custom({
    Expression<String>? feedKey,
    Expression<String>? recipeId,
    Expression<int>? page,
    Expression<int>? position,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (feedKey != null) 'feed_key': feedKey,
      if (recipeId != null) 'recipe_id': recipeId,
      if (page != null) 'page': page,
      if (position != null) 'position': position,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedRecipeFeedEntriesCompanion copyWith({
    Value<String>? feedKey,
    Value<String>? recipeId,
    Value<int>? page,
    Value<int>? position,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedRecipeFeedEntriesCompanion(
      feedKey: feedKey ?? this.feedKey,
      recipeId: recipeId ?? this.recipeId,
      page: page ?? this.page,
      position: position ?? this.position,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (feedKey.present) {
      map['feed_key'] = Variable<String>(feedKey.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipeFeedEntriesCompanion(')
          ..write('feedKey: $feedKey, ')
          ..write('recipeId: $recipeId, ')
          ..write('page: $page, ')
          ..write('position: $position, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedRecipesTable cachedRecipes = $CachedRecipesTable(this);
  late final $CachedRecipeFeedEntriesTable cachedRecipeFeedEntries =
      $CachedRecipeFeedEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedRecipes,
    cachedRecipeFeedEntries,
  ];
}

typedef $$CachedRecipesTableCreateCompanionBuilder =
    CachedRecipesCompanion Function({
      required String id,
      required String title,
      Value<String?> imageUrl,
      required int cookMinutes,
      required String difficulty,
      required String category,
      required String authorJson,
      required double ratingAvg,
      required int ratingCount,
      required bool isFavorite,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedRecipesTableUpdateCompanionBuilder =
    CachedRecipesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> imageUrl,
      Value<int> cookMinutes,
      Value<String> difficulty,
      Value<String> category,
      Value<String> authorJson,
      Value<double> ratingAvg,
      Value<int> ratingCount,
      Value<bool> isFavorite,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

final class $$CachedRecipesTableReferences
    extends BaseReferences<_$AppDatabase, $CachedRecipesTable, CachedRecipe> {
  $$CachedRecipesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $CachedRecipeFeedEntriesTable,
    List<CachedRecipeFeedEntry>
  >
  _cachedRecipeFeedEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cachedRecipeFeedEntries,
        aliasName: 'cached_recipes__id__cached_recipe_feed_entries__recipe_id',
      );

  $$CachedRecipeFeedEntriesTableProcessedTableManager
  get cachedRecipeFeedEntriesRefs {
    final manager = $$CachedRecipeFeedEntriesTableTableManager(
      $_db,
      $_db.cachedRecipeFeedEntries,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cachedRecipeFeedEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CachedRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedRecipesTable> {
  $$CachedRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookMinutes => $composableBuilder(
    column: $table.cookMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorJson => $composableBuilder(
    column: $table.authorJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ratingAvg => $composableBuilder(
    column: $table.ratingAvg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratingCount => $composableBuilder(
    column: $table.ratingCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cachedRecipeFeedEntriesRefs(
    Expression<bool> Function($$CachedRecipeFeedEntriesTableFilterComposer f) f,
  ) {
    final $$CachedRecipeFeedEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cachedRecipeFeedEntries,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CachedRecipeFeedEntriesTableFilterComposer(
                $db: $db,
                $table: $db.cachedRecipeFeedEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CachedRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedRecipesTable> {
  $$CachedRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookMinutes => $composableBuilder(
    column: $table.cookMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorJson => $composableBuilder(
    column: $table.authorJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratingAvg => $composableBuilder(
    column: $table.ratingAvg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratingCount => $composableBuilder(
    column: $table.ratingCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedRecipesTable> {
  $$CachedRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get cookMinutes => $composableBuilder(
    column: $table.cookMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get authorJson => $composableBuilder(
    column: $table.authorJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ratingAvg =>
      $composableBuilder(column: $table.ratingAvg, builder: (column) => column);

  GeneratedColumn<int> get ratingCount => $composableBuilder(
    column: $table.ratingCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  Expression<T> cachedRecipeFeedEntriesRefs<T extends Object>(
    Expression<T> Function($$CachedRecipeFeedEntriesTableAnnotationComposer a)
    f,
  ) {
    final $$CachedRecipeFeedEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cachedRecipeFeedEntries,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CachedRecipeFeedEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.cachedRecipeFeedEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CachedRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedRecipesTable,
          CachedRecipe,
          $$CachedRecipesTableFilterComposer,
          $$CachedRecipesTableOrderingComposer,
          $$CachedRecipesTableAnnotationComposer,
          $$CachedRecipesTableCreateCompanionBuilder,
          $$CachedRecipesTableUpdateCompanionBuilder,
          (CachedRecipe, $$CachedRecipesTableReferences),
          CachedRecipe,
          PrefetchHooks Function({bool cachedRecipeFeedEntriesRefs})
        > {
  $$CachedRecipesTableTableManager(_$AppDatabase db, $CachedRecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> cookMinutes = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> authorJson = const Value.absent(),
                Value<double> ratingAvg = const Value.absent(),
                Value<int> ratingCount = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedRecipesCompanion(
                id: id,
                title: title,
                imageUrl: imageUrl,
                cookMinutes: cookMinutes,
                difficulty: difficulty,
                category: category,
                authorJson: authorJson,
                ratingAvg: ratingAvg,
                ratingCount: ratingCount,
                isFavorite: isFavorite,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> imageUrl = const Value.absent(),
                required int cookMinutes,
                required String difficulty,
                required String category,
                required String authorJson,
                required double ratingAvg,
                required int ratingCount,
                required bool isFavorite,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedRecipesCompanion.insert(
                id: id,
                title: title,
                imageUrl: imageUrl,
                cookMinutes: cookMinutes,
                difficulty: difficulty,
                category: category,
                authorJson: authorJson,
                ratingAvg: ratingAvg,
                ratingCount: ratingCount,
                isFavorite: isFavorite,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedRecipesTable, CachedRecipe>(table),
                  $$CachedRecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cachedRecipeFeedEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cachedRecipeFeedEntriesRefs) db.cachedRecipeFeedEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cachedRecipeFeedEntriesRefs)
                    await $_getPrefetchedData<
                      CachedRecipe,
                      $CachedRecipesTable,
                      CachedRecipeFeedEntry
                    >(
                      currentTable: table,
                      referencedTable: $$CachedRecipesTableReferences
                          ._cachedRecipeFeedEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CachedRecipesTableReferences(
                            db,
                            table,
                            p0,
                          ).cachedRecipeFeedEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.recipeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CachedRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedRecipesTable,
      CachedRecipe,
      $$CachedRecipesTableFilterComposer,
      $$CachedRecipesTableOrderingComposer,
      $$CachedRecipesTableAnnotationComposer,
      $$CachedRecipesTableCreateCompanionBuilder,
      $$CachedRecipesTableUpdateCompanionBuilder,
      (CachedRecipe, $$CachedRecipesTableReferences),
      CachedRecipe,
      PrefetchHooks Function({bool cachedRecipeFeedEntriesRefs})
    >;
typedef $$CachedRecipeFeedEntriesTableCreateCompanionBuilder =
    CachedRecipeFeedEntriesCompanion Function({
      required String feedKey,
      required String recipeId,
      required int page,
      required int position,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedRecipeFeedEntriesTableUpdateCompanionBuilder =
    CachedRecipeFeedEntriesCompanion Function({
      Value<String> feedKey,
      Value<String> recipeId,
      Value<int> page,
      Value<int> position,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

final class $$CachedRecipeFeedEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CachedRecipeFeedEntriesTable,
          CachedRecipeFeedEntry
        > {
  $$CachedRecipeFeedEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CachedRecipesTable _recipeIdTable(_$AppDatabase db) => db
      .cachedRecipes
      .createAlias('cached_recipe_feed_entries__recipe_id__cached_recipes__id');

  $$CachedRecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$CachedRecipesTableTableManager(
      $_db,
      $_db.cachedRecipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CachedRecipeFeedEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedRecipeFeedEntriesTable> {
  $$CachedRecipeFeedEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get feedKey => $composableBuilder(
    column: $table.feedKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CachedRecipesTableFilterComposer get recipeId {
    final $$CachedRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.cachedRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedRecipesTableFilterComposer(
            $db: $db,
            $table: $db.cachedRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedRecipeFeedEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedRecipeFeedEntriesTable> {
  $$CachedRecipeFeedEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get feedKey => $composableBuilder(
    column: $table.feedKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CachedRecipesTableOrderingComposer get recipeId {
    final $$CachedRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.cachedRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.cachedRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedRecipeFeedEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedRecipeFeedEntriesTable> {
  $$CachedRecipeFeedEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get feedKey =>
      $composableBuilder(column: $table.feedKey, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  $$CachedRecipesTableAnnotationComposer get recipeId {
    final $$CachedRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.cachedRecipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.cachedRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedRecipeFeedEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedRecipeFeedEntriesTable,
          CachedRecipeFeedEntry,
          $$CachedRecipeFeedEntriesTableFilterComposer,
          $$CachedRecipeFeedEntriesTableOrderingComposer,
          $$CachedRecipeFeedEntriesTableAnnotationComposer,
          $$CachedRecipeFeedEntriesTableCreateCompanionBuilder,
          $$CachedRecipeFeedEntriesTableUpdateCompanionBuilder,
          (CachedRecipeFeedEntry, $$CachedRecipeFeedEntriesTableReferences),
          CachedRecipeFeedEntry,
          PrefetchHooks Function({bool recipeId})
        > {
  $$CachedRecipeFeedEntriesTableTableManager(
    _$AppDatabase db,
    $CachedRecipeFeedEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedRecipeFeedEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedRecipeFeedEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedRecipeFeedEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> feedKey = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<int> page = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedRecipeFeedEntriesCompanion(
                feedKey: feedKey,
                recipeId: recipeId,
                page: page,
                position: position,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String feedKey,
                required String recipeId,
                required int page,
                required int position,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedRecipeFeedEntriesCompanion.insert(
                feedKey: feedKey,
                recipeId: recipeId,
                page: page,
                position: position,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $CachedRecipeFeedEntriesTable,
                    CachedRecipeFeedEntry
                  >(table),
                  $$CachedRecipeFeedEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable:
                            $$CachedRecipeFeedEntriesTableReferences
                                ._recipeIdTable(db),
                        referencedColumn:
                            $$CachedRecipeFeedEntriesTableReferences
                                ._recipeIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CachedRecipeFeedEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedRecipeFeedEntriesTable,
      CachedRecipeFeedEntry,
      $$CachedRecipeFeedEntriesTableFilterComposer,
      $$CachedRecipeFeedEntriesTableOrderingComposer,
      $$CachedRecipeFeedEntriesTableAnnotationComposer,
      $$CachedRecipeFeedEntriesTableCreateCompanionBuilder,
      $$CachedRecipeFeedEntriesTableUpdateCompanionBuilder,
      (CachedRecipeFeedEntry, $$CachedRecipeFeedEntriesTableReferences),
      CachedRecipeFeedEntry,
      PrefetchHooks Function({bool recipeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedRecipesTableTableManager get cachedRecipes =>
      $$CachedRecipesTableTableManager(_db, _db.cachedRecipes);
  $$CachedRecipeFeedEntriesTableTableManager get cachedRecipeFeedEntries =>
      $$CachedRecipeFeedEntriesTableTableManager(
        _db,
        _db.cachedRecipeFeedEntries,
      );
}

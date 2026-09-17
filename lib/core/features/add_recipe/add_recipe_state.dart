import 'dart:io';

import 'package:recipe_box_app/models/recipe_enums.dart';

class AddRecipeState {
  final String title;
  final File? image;
  final Category? category;
  final Difficulty? difficulty;
  final int cookingTime;
  final List<String> ingredients;
  final List<String> steps;
  final AddRecipeStatus status;
  final String? errorMessage;
  final String? titleError;
  final String? categoryError;
  final String? difficultyError;
  final String? cookingTimeError;
  final String? ingredientsError;
  final String? stepsError;

  const AddRecipeState({
    this.title = '',
    this.image,
    this.category,
    this.difficulty,
    this.cookingTime = 30,
    this.ingredients = const [],
    this.steps = const [],
    this.status = AddRecipeStatus.idle,
    this.errorMessage,
    this.titleError,
    this.categoryError,
    this.difficultyError,
    this.cookingTimeError,
    this.ingredientsError,
    this.stepsError,
  });

  static const _unset = Object();

  AddRecipeState copyWith({
    String? title,
    Object? image = _unset,
    Object? category = _unset,
    Object? difficulty = _unset,
    int? cookingTime,
    List<String>? ingredients,
    List<String>? steps,
    AddRecipeStatus? status,
    Object? errorMessage = _unset,
    Object? titleError = _unset,
    Object? categoryError = _unset,
    Object? difficultyError = _unset,
    Object? cookingTimeError = _unset,
    Object? ingredientsError = _unset,
    Object? stepsError = _unset,
  }) {
    return AddRecipeState(
      title: title ?? this.title,
      image: identical(image, _unset) ? this.image : image as File?,
      difficulty: identical(difficulty, _unset)
          ? this.difficulty
          : difficulty as Difficulty?,
      category: identical(category, _unset)
          ? this.category
          : category as Category?,
      cookingTime: cookingTime ?? this.cookingTime,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      status: status ?? this.status,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      titleError: identical(titleError, _unset)
          ? this.titleError
          : titleError as String?,
      categoryError: identical(categoryError, _unset)
          ? this.categoryError
          : categoryError as String?,
      difficultyError: identical(difficultyError, _unset)
          ? this.difficultyError
          : difficultyError as String?,
      cookingTimeError: identical(cookingTimeError, _unset)
          ? this.cookingTimeError
          : cookingTimeError as String?,
      ingredientsError: identical(ingredientsError, _unset)
          ? this.ingredientsError
          : ingredientsError as String?,
      stepsError: identical(stepsError, _unset)
          ? this.stepsError
          : stepsError as String?,
    );
  }
}

enum AddRecipeStatus { idle, saving, success, error }

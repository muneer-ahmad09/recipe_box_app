enum Difficulty { easy, medium, hard }

enum Category { breakfast, lunch, dinner, dessert }

Difficulty convertApiDifficultyToEnum(String apiDifficulty) {
  switch (apiDifficulty) {
    case "Easy":
      return Difficulty.easy;
    case "Medium":
      return Difficulty.medium;
    case "Hard":
      return Difficulty.hard;
    default:
      throw Exception("Invalid difficulty: $apiDifficulty");
  }
}

Category convertApiCategoryToEnum(String apiCategory) {
  switch (apiCategory) {
    case "Breakfast":
      return Category.breakfast;
    case "Lunch":
      return Category.lunch;
    case "Dinner":
      return Category.dinner;
    case "Dessert":
      return Category.dessert;
    default:
      throw Exception("Invalid category: $apiCategory");
  }
}

String difficultyEnumToString(Difficulty difficulty) {
  switch (difficulty) {
    case Difficulty.easy:
      return "Easy";
    case Difficulty.medium:
      return "Medium";
    case Difficulty.hard:
      return "Hard";
  }
}

String categoryEnumToString(Category category) {
  switch (category) {
    case Category.breakfast:
      return "Breakfast";
    case Category.lunch:
      return "Lunch";
    case Category.dinner:
      return "Dinner";
    case Category.dessert:
      return "Dessert";
  }

}
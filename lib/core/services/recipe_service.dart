import '../../models/page.dart';
import '../../models/recipe_card.dart';
import '../network/api_client.dart';

class RecipeService {
  final ApiClient apiClient;

  RecipeService(this.apiClient);

  Future<Page<RecipeCard>> getNewestRecipes({String? category}) {
    return apiClient.getRecipes(category: category);
  }

}
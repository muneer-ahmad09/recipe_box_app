import '../../models/favorite_api_model.dart';
import '../../models/page.dart';
import '../../models/recipe_card.dart';
import '../network/api_client.dart';

class RecipeService {
  final ApiClient apiClient;

  RecipeService(this.apiClient);

  Future<Page<RecipeCard>> getRecipes({
    int page=1,
    int pageSize=10,
    String? category,
    String? search,
    String sort='newest',
    int? maxCookMinutes,
  }) {
    return apiClient.getRecipes(
      page: page,
      pageSize: pageSize,
      category: category,
      search: search,
      sort: sort,
      maxCookMinutes: maxCookMinutes,
    );
  }
  Future<FavoriteApiModel> toggleFavorite(String recipeId) {
    return apiClient.toggleFavorite(recipeId);
  }
}

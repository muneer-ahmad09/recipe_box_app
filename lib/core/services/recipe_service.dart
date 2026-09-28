import '../../models/profile_review.dart';
import '../../models/create_review_request.dart';
import '../../models/favorite_api_model.dart';
import '../../models/page.dart';
import '../../models/recipe_card.dart';
import '../../models/recipe_create_request.dart';
import '../../models/recipe_detail.dart';
import '../../models/review.dart';
import '../network/api_client.dart';

class RecipeService {
  final ApiClient apiClient;

  RecipeService(this.apiClient);

  Future<Page<RecipeCard>> getRecipes({
    int page=1,
    int pageSize=10,
    String? category,
    String? search,
    String? sort,
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

  Future<RecipeDetail> createRecipe(RecipeCreateRequest request) {
    return apiClient.createRecipe(request);
  }

  Future<Page<RecipeCard>> getMyRecipes({
    int page = 1,
    int pageSize = 10,
  }) {
    return apiClient.getMyRecipes(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Page<RecipeCard>> getSavedRecipes({
    int page = 1,
    int pageSize = 10,
  }) async {
    return apiClient.getSavedRecipes(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<RecipeDetail> getRecipe(String recipeId) {
    return apiClient.getRecipe(recipeId);
  }

  Future<Review> createReview({
    required String recipeId,
    required CreateReviewRequest request,
  }) async {
    return apiClient.createReview(
      recipeId,
      request,
    );
  }

  Future<Page<Review>> getReviews({
    required String recipeId,
    int page = 1,
    int pageSize = 10,
  }) async {
    return apiClient.getReviews(
      recipeId: recipeId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Page<ProfileReview>> getUserReviews({
    required String userId,
    int page = 1,
    int pageSize = 10,
  }) {
    return apiClient.getUserReviews(
      userId: userId,
      page: page,
      pageSize: pageSize,
    );
  }

}

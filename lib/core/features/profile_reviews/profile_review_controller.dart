import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/features/profile_reviews/profile_review_state.dart';

import '../../services/recipe_service.dart';
import '../providers.dart';

class ProfileReviewController extends Notifier<ProfileReviewState> {
  late final RecipeService _recipeService;

  @override
  ProfileReviewState build() {
    _recipeService = ref.read(recipeServiceProvider);

    return const ProfileReviewState();
  }

  Future<void> loadReviews({
    required String userId,
    int page = 1,
    int pageSize = 10,
  }) async {
    if (page == 1) {
      if (state.isLoading) {
        return;
      }

      state = state.copyWith(
        isLoading: true,
        clearError: true,
        reviews: [],
        currentPage: 0,
        totalPages: 0,
      );
    } else {
      if (state.isLoadingMore || !state.hasMore) {
        return;
      }

      state = state.copyWith(
        isLoadingMore: true,
        clearError: true,
      );
    }

    try {
      final result = await _recipeService.getUserReviews(
        userId: userId,
        page: page,
        pageSize: pageSize,
      );

      final reviews = page == 1
          ? result.items
          : [...state.reviews, ...result.items];

      state = state.copyWith(
        reviews: reviews,
        isLoading: false,
        isLoadingMore: false,
        currentPage: result.page,
        totalPages: result.pages,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: 'Failed to load reviews. Please try again.',
      );
    }
  }

  void reset() {
    state = const ProfileReviewState();
  }
}

final profileReviewProvider =
NotifierProvider<ProfileReviewController, ProfileReviewState>(
  ProfileReviewController.new,
);
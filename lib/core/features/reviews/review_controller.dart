import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/create_review_request.dart';
import '../../services/recipe_service.dart';
import '../providers.dart';
import 'review_state.dart';

class ReviewController extends Notifier<ReviewState> {
  late final RecipeService _recipeService;

  @override
  ReviewState build() {
    _recipeService = ref.read(recipeServiceProvider);

    return const ReviewState();
  }

  Future<void> createReview({
    required String recipeId,
    required int rating,
    required String comment,
  }) async {
    state = state.copyWith(
      isSubmitting: true,
      isSuccess: false,
      clearError: true,
    );

    try {
      final request = CreateReviewRequest(rating: rating, comment: comment);

      await _recipeService.createReview(recipeId: recipeId, request: request);

      state = state.copyWith(isSubmitting: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: 'Failed to post review. Please try again.',
      );
    }
  }

  Future<void> getReviews({
    required String recipeId,
    int page = 1,
    int pageSize = 10,
  }) async {
    if (state.isLoading || state.isLoadingMore) {
      return;
    }

    final isFirstPage = page == 1;

    if (!isFirstPage && !state.hasMore) {
      return;
    }

    state = state.copyWith(
      isLoading: isFirstPage,
      isLoadingMore: !isFirstPage,
      clearError: true,
    );

    try {
      final pageResult = await _recipeService.getReviews(
        recipeId: recipeId,
        page: page,
        pageSize: pageSize,
      );

      final reviews = isFirstPage
          ? pageResult.items
          : [
        ...state.reviews,
        ...pageResult.items,
      ];

      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        reviews: reviews,
        currentPage: pageResult.page,
        totalPages: pageResult.pages,
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
    state = const ReviewState();
  }
}

final reviewProvider = NotifierProvider<ReviewController, ReviewState>(
  ReviewController.new,
);

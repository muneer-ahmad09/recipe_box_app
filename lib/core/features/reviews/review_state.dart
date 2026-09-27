import '../../../models/review.dart';

class ReviewState {
  final List<Review> reviews;
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;
  final bool isLoadingMore;
  final int currentPage;
  final int totalPages;

  const ReviewState({
    this.reviews = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
    this.isLoadingMore=false,
    this.currentPage=0,
     this.totalPages=0,
  });

  bool get hasMore => currentPage < totalPages;

  ReviewState copyWith({
    List<Review>? reviews,
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
    bool clearError = false,
    bool? isLoadingMore,
    int? currentPage,
    int? totalPages,
  }) {
    return ReviewState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
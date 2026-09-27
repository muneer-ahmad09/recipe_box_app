import '../../../models/ProfileReview.dart';

class ProfileReviewState {
  final List<ProfileReview> reviews;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;

  final int currentPage;
  final int totalPages;

  const ProfileReviewState({
    this.reviews = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
  });

  bool get hasMore => currentPage < totalPages;

  ProfileReviewState copyWith({
    List<ProfileReview>? reviews,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool clearError = false,
  }) {
    return ProfileReviewState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
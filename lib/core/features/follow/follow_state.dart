class FollowState {
  final Set<String> loadingIds;
  final String? errorMessage;

  const FollowState({
    this.loadingIds = const {},
    this.errorMessage,
  });

  FollowState copyWith({
    Set<String>? loadingIds,
    String? errorMessage,
  }) {
    return FollowState(
      loadingIds: loadingIds ?? this.loadingIds,
      errorMessage: errorMessage,
    );
  }
}
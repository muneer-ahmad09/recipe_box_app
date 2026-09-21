class FavoriteState {
  static const _unset = Object();

  final Set<String> loadingIds;
  final String? errorMessage;

  const FavoriteState({
    this.loadingIds = const {},
    this.errorMessage,
  });

  FavoriteState copyWith({
    Set<String>? loadingIds,
    Object? errorMessage = _unset,
  }) {
    return FavoriteState(
      loadingIds: loadingIds ?? this.loadingIds,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
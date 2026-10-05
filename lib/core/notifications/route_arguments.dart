class RecipeRouteArguments {
  final String id;
  final String? initialImageUrl;

  const RecipeRouteArguments({
    required this.id,
    this.initialImageUrl,
  });
}

class ProfileRouteArguments {
  final String userId;

  const ProfileRouteArguments({
    required this.userId,
  });
}
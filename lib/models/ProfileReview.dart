class ProfileReview {
  final String id;
  final int rating;
  final String comment;
  final String recipeId;
  final String recipeTitle;
  final String recipeImageUrl;
  final DateTime createdAt;

  const ProfileReview({
    required this.id,
    required this.rating,
    required this.comment,
    required this.recipeId,
    required this.recipeTitle,
    required this.recipeImageUrl,
    required this.createdAt,
  });

  factory ProfileReview.fromJson(Map<String, dynamic> json) {
    final recipe = json['recipe'] as Map<String, dynamic>;

    return ProfileReview(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      recipeId: recipe['id'],
      recipeTitle: recipe['title'],
      recipeImageUrl: recipe['image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
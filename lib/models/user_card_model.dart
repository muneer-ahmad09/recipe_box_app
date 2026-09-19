class UserCardModel {
  final String id;
  final String username;
  final String fullName;
  final String? avatarUrl;
  final int recipeCount;
  final int followerCount;
  final bool isFollowing;

  const UserCardModel({
    required this.id,
    required this.username,
    required this.fullName,
    this.avatarUrl,
    required this.recipeCount,
    required this.followerCount,
    required this.isFollowing,
  });

  factory UserCardModel.fromJson(Map<String, dynamic> json) {
   return UserCardModel( id: json['id'],
    username: json['username'],
    fullName: json['full_name'],
    avatarUrl: json['avatar_url'],
    recipeCount: json['recipe_count'],
    followerCount: json['follower_count'],
    isFollowing: json['is_following'],
    );
  }
}
class UserProfileModel {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String? bio;
  final String? location;
  final String? avatarUrl;
  final DateTime createdAt;

  final int recipeCount;
  final int followerCount;
  final int followingCount;
  final bool isFollowing;

  const UserProfileModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    this.bio,
    this.location,
    this.avatarUrl,
    required this.createdAt,
    required this.recipeCount,
    required this.followerCount,
    required this.followingCount,
    required this.isFollowing,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      username: json['username'],
      fullName: json['full_name'],
      email: json['email'],
      bio: json['bio'],
      location: json['location'],
      avatarUrl: json['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
      recipeCount: json['recipe_count'],
      followerCount: json['follower_count'],
      followingCount: json['following_count'],
      isFollowing: json['is_following'] ?? false,
    );
  }

  UserProfileModel copyWith({
    String? id,
    String? username,
    String? fullName,
    String? email,
    String? bio,
    String? location,
    String? avatarUrl,
    DateTime? createdAt,
    int? recipeCount,
    int? followerCount,
    int? followingCount,
    bool? isFollowing,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      recipeCount: recipeCount ?? this.recipeCount,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
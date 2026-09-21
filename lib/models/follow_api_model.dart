class FollowApiModel {
  final bool isFollowing;

  const FollowApiModel({
    required this.isFollowing,
  });

  factory FollowApiModel.fromJson(Map<String, dynamic> json) {
    return FollowApiModel(
      isFollowing: json['is_following'] as bool,
    );
  }
}
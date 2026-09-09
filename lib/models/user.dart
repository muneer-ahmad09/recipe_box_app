class User {
  final String id;
  final String fullName;
  final String email;
  final String? bio;
  final String? avatarUrl;
  final String? location;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    this.bio,
    this.avatarUrl,
    this.location,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      bio: json['bio'],
      avatarUrl: json['avatar_url'],
      location: json['location'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Author {
  final String id;
  final String fullName;
  final String? avatarUrl;

  const Author({required this.id, required this.fullName, this.avatarUrl});

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(
      id: json['id'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'avatar_url': avatarUrl,
    };
  }

}

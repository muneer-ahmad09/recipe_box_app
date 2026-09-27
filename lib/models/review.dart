import 'author.dart';

class Review {
  final String id;
  final int rating;
  final String comment;
  final Author author;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.rating,
    required this.comment,
    required this.author,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      author: Author.fromJson(json['author']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
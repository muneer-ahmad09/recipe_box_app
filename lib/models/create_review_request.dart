class CreateReviewRequest {
  final int rating;
  final String comment;

  const CreateReviewRequest({
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
    };
  }
}
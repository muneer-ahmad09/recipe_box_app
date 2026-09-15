class FavoriteApiModel {
  final bool isFavorite;
  FavoriteApiModel({required this.isFavorite});

  factory FavoriteApiModel.fromJson(Map<String, dynamic> json) {
    return FavoriteApiModel(isFavorite: json['is_favorite']);

  }
}
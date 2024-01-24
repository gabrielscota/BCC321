class RatingEntity {
  final String id;
  final int rating;
  final String? comment;
  final int userId;

  RatingEntity({
    required this.id,
    required this.rating,
    this.comment,
    required this.userId,
  });
}

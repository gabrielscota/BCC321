import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class RatingDto {
  final String id;
  final int rating;
  final String? comment;
  final int userId;

  RatingDto({
    required this.id,
    required this.rating,
    this.comment,
    required this.userId,
  });

  factory RatingDto.fromMap(Map<String, dynamic> map) {
    try {
      return RatingDto(
        id: map['id'].toString(),
        rating: map['rating'] as int,
        comment: map['comment'] as String?,
        userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing rating from map');
    }
  }

  RatingEntity toEntity() {
    return RatingEntity(
      id: id,
      rating: rating,
      comment: comment,
      userId: userId,
    );
  }
}

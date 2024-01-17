import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class UserDto {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory UserDto.fromMap(Map<String, dynamic> map) {
    try {
      return UserDto(
        id: map['id'].toString(),
        name: map['name'] as String,
        email: map['email'] as String,
        photoUrl: map['photoUrl'] as String,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing user from map');
    }
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
    );
  }
}

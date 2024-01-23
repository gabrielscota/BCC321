import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class UserDto {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String displayName;

  UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.displayName,
  });

  factory UserDto.fromMap(Map<String, dynamic> map) {
    try {
      return UserDto(
        id: map['id'].toString(),
        name: map['name'] as String,
        email: map['email'] as String,
        phone: map['phone'] as String,
        photoUrl: map['photo_url'] != null ? map['photo_url'] as String : '',
        displayName: map['display_name'] != null ? map['display_name'] as String : '',
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing user from map');
    }
  }

  factory UserDto.fromEntity(UserEntity entity) {
    return UserDto(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      photoUrl: entity.photoUrl,
      displayName: entity.displayName,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      displayName: displayName,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo_url': photoUrl,
      'display_name': displayName,
    };
  }
}

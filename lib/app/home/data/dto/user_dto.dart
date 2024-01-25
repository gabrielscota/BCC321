import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class UserDto {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String displayName;
  final String cpf;
  final String cnpj;

  UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.displayName,
    required this.cpf,
    required this.cnpj,
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
        cpf: map['cpf'] != null ? map['cpf'] as String : '',
        cnpj: map['cnpj'] != null ? map['cnpj'] as String : '',
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
      phone: phone,
      photoUrl: photoUrl,
      displayName: displayName,
      cpf: cpf,
      cnpj: cnpj,
    );
  }
}

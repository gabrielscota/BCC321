import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';
import 'dto.dart';

class LegalPersonUserDto {
  final UserDto user;
  final String cnpj;

  LegalPersonUserDto({
    required this.user,
    required this.cnpj,
  });

  factory LegalPersonUserDto.fromMap(Map<String, dynamic> map) {
    try {
      return LegalPersonUserDto(
        user: UserDto.fromMap(map['user'] as Map<String, dynamic>),
        cnpj: map['cnpj'] as String,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing physical person user from map');
    }
  }

  LegalPersonUserEntity toEntity() {
    return LegalPersonUserEntity(
      user: user.toEntity(),
      cnpj: cnpj,
    );
  }

  Map toMap() {
    return {
      'user_id': int.parse(user.id),
      'cnpj': cnpj,
    };
  }
}

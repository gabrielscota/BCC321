import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';
import 'dto.dart';

class PhysicalPersonUserDto {
  final UserDto user;
  final String cpf;

  PhysicalPersonUserDto({
    required this.user,
    required this.cpf,
  });

  factory PhysicalPersonUserDto.fromMap(Map<String, dynamic> map) {
    try {
      return PhysicalPersonUserDto(
        user: UserDto.fromMap(map['user'] as Map<String, dynamic>),
        cpf: map['cpf'] as String,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing physical person user from map');
    }
  }

  PhysicalPersonUserEntity toEntity() {
    return PhysicalPersonUserEntity(
      user: user.toEntity(),
      cpf: cpf,
    );
  }

  Map toMap() {
    return {
      'user_id': int.parse(user.id),
      'cpf': cpf,
    };
  }
}

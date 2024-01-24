import 'entities.dart';

class PhysicalPersonUserEntity {
  final UserEntity user;
  final String cpf;

  PhysicalPersonUserEntity({
    required this.user,
    required this.cpf,
  });
}

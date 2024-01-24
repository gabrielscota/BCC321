import 'entities.dart';

class LegalPersonUserEntity {
  final UserEntity user;
  final String cnpj;

  LegalPersonUserEntity({
    required this.user,
    required this.cnpj,
  });
}

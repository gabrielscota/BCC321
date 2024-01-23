import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class SignUpUseCase {
  final SignUpRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, void>> call({required SignUpUseCaseParams params}) async {
    try {
      await repository.signUp(
        name: params.name,
        email: params.email,
        phone: params.phone,
        password: params.password,
        cpf: params.cpf,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class SignUpUseCaseParams {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String cpf;

  SignUpUseCaseParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.cpf,
  });
}

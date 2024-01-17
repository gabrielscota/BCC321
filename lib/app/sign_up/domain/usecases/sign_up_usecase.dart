import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class SignUpUseCase {
  final SignUpRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String email, required String password}) async {
    try {
      await repository.signUp(email: email, password: password);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class SignInUseCase {
  final SignInRepository repository;

  SignInUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String email, required String password}) async {
    try {
      await repository.signIn(email: email, password: password);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

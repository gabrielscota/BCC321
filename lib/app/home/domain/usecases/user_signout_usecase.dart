import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class UserSignOutUseCase {
  final UserSignOutRepository repository;

  UserSignOutUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    try {
      final result = await repository.signOut();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

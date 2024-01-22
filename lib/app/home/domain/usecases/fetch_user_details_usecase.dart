import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchUserDetailsUseCase {
  final UserDetailsRepository repository;

  FetchUserDetailsUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call() async {
    try {
      final result = await repository.fetchUserDetails();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

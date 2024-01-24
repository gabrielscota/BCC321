import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class VerifyIfUserIsSellerUseCase {
  final UserDetailsRepository repository;

  VerifyIfUserIsSellerUseCase({required this.repository});

  Future<Either<Failure, bool>> call({required String userId}) async {
    try {
      final result = await repository.verifyIfUserIsSeller(userId: userId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

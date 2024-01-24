import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchSellerDetailsUseCase {
  final SellerDetailsRepository repository;

  FetchSellerDetailsUseCase({required this.repository});

  Future<Either<Failure, SellerEntity>> call({required String sellerId}) async {
    try {
      final result = await repository.fetchSellerDetails(sellerId: sellerId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

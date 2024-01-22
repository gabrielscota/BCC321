import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchSellerListUseCase {
  final SellerRepository repository;

  FetchSellerListUseCase({required this.repository});

  Future<Either<Failure, List<SellerEntity>>> call() async {
    try {
      final result = await repository.fetchSellerList();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

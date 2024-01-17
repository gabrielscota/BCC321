import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchProductDetailsUseCase {
  final ProductDetailsRepository repository;

  FetchProductDetailsUseCase({required this.repository});

  Future<Either<Failure, ProductEntity>> call({required String productId}) async {
    try {
      final result = await repository.fetchProductDetails(productId: productId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

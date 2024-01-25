import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class DeleteProductUseCase {
  final SellerProductsRepository repository;

  DeleteProductUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String productId}) async {
    try {
      final result = await repository.deleteProduct(productId: productId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

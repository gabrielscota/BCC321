import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class EditProductUseCase {
  final EditProductRepository repository;

  EditProductUseCase({required this.repository});

  Future<Either<Failure, void>> call({required EditProductUseCaseParams params}) async {
    try {
      await repository.editProduct(
        productId: params.productId,
        description: params.description,
        stockQuantity: params.stockQuantity,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class EditProductUseCaseParams {
  final String productId;
  final String description;
  final int stockQuantity;

  EditProductUseCaseParams({
    required this.productId,
    required this.description,
    required this.stockQuantity,
  });
}

import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class AddProductUseCase {
  final AddProductRepository repository;

  AddProductUseCase({required this.repository});

  Future<Either<Failure, void>> call({required AddProductUseCaseParams params}) async {
    try {
      await repository.addProduct(
        name: params.name,
        description: params.description,
        price: params.price,
        categoryId: params.categoryId,
        stockQuantity: params.stockQuantity,
        sellerId: params.sellerId,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class AddProductUseCaseParams {
  final String name;
  final String description;
  final int price;
  final String categoryId;
  final int stockQuantity;
  final int sellerId;

  AddProductUseCaseParams({
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.stockQuantity,
    required this.sellerId,
  });
}

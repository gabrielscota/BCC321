import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchShopProductListUseCase {
  final ShopProductRepository repository;

  FetchShopProductListUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({required String sellerId}) async {
    try {
      final result = await repository.fetchProductList(sellerId: sellerId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

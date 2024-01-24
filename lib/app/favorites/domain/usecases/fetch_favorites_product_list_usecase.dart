import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchFavoritesProductListUseCase {
  final FavoritesProductsRepository repository;

  FetchFavoritesProductListUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({required String userId}) async {
    try {
      final result = await repository.fetchProductList(userId: userId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

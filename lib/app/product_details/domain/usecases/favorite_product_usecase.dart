import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class FavoriteProductUseCase {
  final ProductDetailsRepository repository;

  FavoriteProductUseCase({required this.repository});

  Future<Either<Failure, bool>> call({required String userId, required String productId}) async {
    try {
      final isFavorite = await repository.favoriteProduct(userId: userId, productId: productId);
      return Right(isFavorite);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

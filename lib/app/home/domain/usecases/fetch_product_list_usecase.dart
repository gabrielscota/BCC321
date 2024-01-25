import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchProductListUseCase {
  final ProductRepository repository;

  FetchProductListUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({String categoryId = ''}) async {
    try {
      final result = await repository.fetchProductList(categoryId: categoryId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchSellerCategoryListUseCase {
  final CategoryRepository repository;

  FetchSellerCategoryListUseCase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    try {
      final result = await repository.fetchCategoryList();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

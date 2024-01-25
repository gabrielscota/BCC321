import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class AddProductFetchCategoryListUseCase {
  final AddProductCategoryRepository repository;

  AddProductFetchCategoryListUseCase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    try {
      final result = await repository.fetchCategoryList();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

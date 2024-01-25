import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchOrderListUseCase {
  final OrderRepository repository;

  FetchOrderListUseCase({required this.repository});

  Future<Either<Failure, List<OrderEntity>>> call({required String userId}) async {
    try {
      final result = await repository.fetchOrderList(userId: userId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

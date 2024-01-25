import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class NewOrderUseCase {
  final HomeOrderRepository repository;

  NewOrderUseCase({required this.repository});

  Future<Either<Failure, void>> call({required NewOrderUseCaseParams params}) async {
    try {
      await repository.newOrder(
        items: params.items,
        addressId: params.addressId,
        userId: params.userId,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class NewOrderUseCaseParams {
  final List<Map<String, dynamic>> items;
  final String addressId;
  final String userId;

  NewOrderUseCaseParams({
    required this.items,
    required this.addressId,
    required this.userId,
  });
}

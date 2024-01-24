import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class SellerCreateUseCase {
  final SellerCreateRepository repository;

  SellerCreateUseCase({required this.repository});

  Future<Either<Failure, void>> call({required SellerCreateUseCaseParams params}) async {
    try {
      await repository.createShop(
        shopName: params.shopName,
        shopDescription: params.shopDescription,
        userId: params.userId,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class SellerCreateUseCaseParams {
  final String shopName;
  final String shopDescription;
  final String userId;

  SellerCreateUseCaseParams({
    required this.shopName,
    required this.shopDescription,
    required this.userId,
  });
}

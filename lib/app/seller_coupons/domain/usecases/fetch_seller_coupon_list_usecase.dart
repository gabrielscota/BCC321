import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchSellerCouponsListUseCase {
  final SellerCouponsRepository repository;

  FetchSellerCouponsListUseCase({required this.repository});

  Future<Either<Failure, List<CouponEntity>>> call({required String sellerId}) async {
    try {
      final result = await repository.fetchCouponList(sellerId: sellerId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

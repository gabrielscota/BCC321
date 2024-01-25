import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class DeleteCouponUseCase {
  final SellerCouponsRepository repository;

  DeleteCouponUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String couponId}) async {
    try {
      final result = await repository.deleteCoupon(couponId: couponId);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

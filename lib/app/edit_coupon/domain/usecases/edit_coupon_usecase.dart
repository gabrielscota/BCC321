import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class EditCouponUseCase {
  final EditCouponRepository repository;

  EditCouponUseCase({required this.repository});

  Future<Either<Failure, void>> call({required EditCouponUseCaseParams params}) async {
    try {
      await repository.editCoupon(
        couponId: params.couponId,
        discountCode: params.discountCode,
        discountValue: params.discountValue,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class EditCouponUseCaseParams {
  final String couponId;
  final String discountCode;
  final double discountValue;

  EditCouponUseCaseParams({
    required this.couponId,
    required this.discountCode,
    required this.discountValue,
  });
}

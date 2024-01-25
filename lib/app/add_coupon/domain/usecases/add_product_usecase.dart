import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class AddCouponUseCase {
  final AddCouponRepository repository;

  AddCouponUseCase({required this.repository});

  Future<Either<Failure, void>> call({required AddCouponUseCaseParams params}) async {
    try {
      await repository.addCoupon(
        discountCode: params.discountCode,
        discountValue: params.discountValue,
        startDate: params.startDate,
        endDate: params.endDate,
        sellerId: params.sellerId,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class AddCouponUseCaseParams {
  final String discountCode;
  final double discountValue;
  final String startDate;
  final String endDate;
  final int sellerId;

  AddCouponUseCaseParams({
    required this.discountCode,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
    required this.sellerId,
  });
}

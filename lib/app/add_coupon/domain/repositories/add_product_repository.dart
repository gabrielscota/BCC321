abstract class AddCouponRepository {
  Future<void> addCoupon({
    required String discountCode,
    required double discountValue,
    required String startDate,
    required String endDate,
    required int sellerId,
  });
}

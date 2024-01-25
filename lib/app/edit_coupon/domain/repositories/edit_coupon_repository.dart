abstract class EditCouponRepository {
  Future<void> editCoupon({required String couponId, required String discountCode, required double discountValue});
}

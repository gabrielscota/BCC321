import '../entities/entities.dart';

abstract class SellerCouponsRepository {
  Future<List<CouponEntity>> fetchCouponList({required String sellerId});
  Future<void> deleteCoupon({required String couponId});
}

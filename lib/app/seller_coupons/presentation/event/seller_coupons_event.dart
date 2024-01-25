part of '../controller/seller_coupons_bloc.dart';

abstract class SellerCouponsEvent {}

class SellerCouponsStartedEvent extends SellerCouponsEvent {
  final String sellerId;

  SellerCouponsStartedEvent({required this.sellerId});
}

class SellerCouponsDeleteCouponEvent extends SellerCouponsEvent {
  final String couponId;

  SellerCouponsDeleteCouponEvent({required this.couponId});
}

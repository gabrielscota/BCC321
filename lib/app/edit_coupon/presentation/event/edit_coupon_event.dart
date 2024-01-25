part of '../controller/edit_coupon_bloc.dart';

abstract class EditCouponEvent {}

class EditCouponStartedEvent extends EditCouponEvent {
  final String couponId;
  final String discountCode;
  final double discountValue;

  EditCouponStartedEvent({
    required this.couponId,
    required this.discountCode,
    required this.discountValue,
  });
}

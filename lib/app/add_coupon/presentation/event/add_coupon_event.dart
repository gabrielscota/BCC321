part of '../controller/add_coupon_bloc.dart';

abstract class AddCouponEvent {}

class AddCouponStartedEvent extends AddCouponEvent {
  final String discountCode;
  final double discountValue;
  final String startDate;
  final String endDate;
  final int sellerId;

  AddCouponStartedEvent({
    required this.discountCode,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
    required this.sellerId,
  });
}

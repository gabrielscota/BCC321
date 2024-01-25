part of '../controller/add_coupon_bloc.dart';

abstract class AddCouponState {}

class AddCouponInitialState extends AddCouponState {}

class AddCouponLoadingState extends AddCouponState {}

class AddCouponSuccessfullState extends AddCouponState {}

class AddCouponErrorState extends AddCouponState {
  final String message;

  AddCouponErrorState({required this.message});
}

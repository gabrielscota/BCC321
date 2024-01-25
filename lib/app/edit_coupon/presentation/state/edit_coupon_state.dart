part of '../controller/edit_coupon_bloc.dart';

abstract class EditCouponState {}

class EditCouponInitialState extends EditCouponState {}

class EditCouponLoadingState extends EditCouponState {}

class EditCouponSuccessfullState extends EditCouponState {}

class EditCouponErrorState extends EditCouponState {
  final String message;

  EditCouponErrorState({required this.message});
}

part of '../controller/seller_coupons_bloc.dart';

abstract class SellerCouponsState {}

class SellerCouponsInitialState extends SellerCouponsState {}

class SellerCouponsPageLoadingState extends SellerCouponsState {}

class SellerCouponsPageLoadedState extends SellerCouponsState {
  final List<CouponEntity> coupons;

  SellerCouponsPageLoadedState({this.coupons = const []});
}

class SellerCouponsPageErrorState extends SellerCouponsState {
  final String message;

  SellerCouponsPageErrorState({required this.message});
}

class SellerCouponsPageDeleteSuccessState extends SellerCouponsState {}

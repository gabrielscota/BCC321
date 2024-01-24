part of '../controller/seller_bloc.dart';

abstract class SellerState {}

class SellerInitialState extends SellerState {}

class SellerPageLoadingState extends SellerState {}

class SellerPageLoadedState extends SellerState {
  final SellerEntity seller;

  SellerPageLoadedState({required this.seller});
}

class SellerPageErrorState extends SellerState {
  final String message;

  SellerPageErrorState({required this.message});
}

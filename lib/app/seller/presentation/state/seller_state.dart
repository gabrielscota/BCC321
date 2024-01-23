part of '../controller/seller_bloc.dart';

abstract class SellerState {}

class SellerInitialState extends SellerState {}

class SellerPageLoadingState extends SellerState {}

class SellerPageLoadedState extends SellerState {
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;

  SellerPageLoadedState({
    this.categories = const [],
    this.products = const [],
  });
}

class SellerPageErrorState extends SellerState {
  final String message;

  SellerPageErrorState({required this.message});
}

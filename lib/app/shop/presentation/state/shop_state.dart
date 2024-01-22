part of '../controller/shop_bloc.dart';

abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopPageLoadingState extends ShopState {}

class ShopPageLoadedState extends ShopState {
  final SellerEntity seller;
  final List<ProductEntity> products;

  ShopPageLoadedState({required this.seller, this.products = const []});
}

class ShopPageErrorState extends ShopState {
  final String message;

  ShopPageErrorState({required this.message});
}

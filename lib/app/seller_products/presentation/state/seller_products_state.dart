part of '../controller/seller_products_bloc.dart';

abstract class SellerProductsState {}

class SellerProductsInitialState extends SellerProductsState {}

class SellerProductsPageLoadingState extends SellerProductsState {}

class SellerProductsPageLoadedState extends SellerProductsState {
  final List<ProductEntity> products;

  SellerProductsPageLoadedState({this.products = const []});
}

class SellerProductsPageErrorState extends SellerProductsState {
  final String message;

  SellerProductsPageErrorState({required this.message});
}

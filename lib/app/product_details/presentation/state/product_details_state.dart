part of '../controller/product_details_bloc.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsPageLoadingState extends ProductDetailsState {}

class ProductDetailsPageLoadedState extends ProductDetailsState {
  final ProductEntity product;

  ProductDetailsPageLoadedState({required this.product});
}

class ProductDetailsPageErrorState extends ProductDetailsState {
  final String message;

  ProductDetailsPageErrorState({required this.message});
}

part of '../controller/product_details_bloc.dart';

abstract class ProductDetailsEvent {}

class ProductDetailsStartedEvent extends ProductDetailsEvent {
  final String productId;
  final String userId;

  ProductDetailsStartedEvent({required this.productId, required this.userId});
}

class ProductDetailsFavoriteEvent extends ProductDetailsEvent {
  final String userId;
  final String productId;

  ProductDetailsFavoriteEvent({required this.userId, required this.productId});
}

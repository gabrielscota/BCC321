part of '../controller/product_details_bloc.dart';

abstract class ProductDetailsEvent {}

class ProductDetailsStartedEvent extends ProductDetailsEvent {
  final String productId;

  ProductDetailsStartedEvent({required this.productId});
}

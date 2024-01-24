part of '../controller/seller_products_bloc.dart';

abstract class SellerProductsEvent {}

class SellerProductsStartedEvent extends SellerProductsEvent {
  final String sellerId;

  SellerProductsStartedEvent({required this.sellerId});
}

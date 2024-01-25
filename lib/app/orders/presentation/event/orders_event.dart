part of '../controller/orders_bloc.dart';

abstract class OrdersEvent {}

class OrdersStartedEvent extends OrdersEvent {
  final String userId;

  OrdersStartedEvent({required this.userId});
}

class OrdersDeleteProductEvent extends OrdersEvent {
  final String productId;

  OrdersDeleteProductEvent({required this.productId});
}

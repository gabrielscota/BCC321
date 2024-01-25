part of '../controller/orders_bloc.dart';

abstract class OrdersState {}

class OrdersInitialState extends OrdersState {}

class OrdersPageLoadingState extends OrdersState {}

class OrdersPageLoadedState extends OrdersState {
  final List<OrderEntity> orders;

  OrdersPageLoadedState({this.orders = const []});
}

class OrdersPageErrorState extends OrdersState {
  final String message;

  OrdersPageErrorState({required this.message});
}

class OrdersPageDeleteSuccessState extends OrdersState {}

part of '../controller/home_bloc.dart';

abstract class HomeEvent {}

class HomeStartedEvent extends HomeEvent {}

class HomeSignOutEvent extends HomeEvent {}

class HomeLoadUserDetailsEvent extends HomeEvent {}

class HomeVerifyIfUserIsSellerEvent extends HomeEvent {}

class HomeNewOrderEvent extends HomeEvent {
  final List<Map<String, dynamic>> items;
  final String addressId;
  final String userId;

  HomeNewOrderEvent({required this.items, required this.addressId, required this.userId});
}

class HomeLoadProductListEvent extends HomeEvent {
  final String categoryId;

  HomeLoadProductListEvent({required this.categoryId});
}

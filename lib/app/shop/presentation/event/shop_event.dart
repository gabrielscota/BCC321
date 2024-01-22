part of '../controller/shop_bloc.dart';

abstract class ShopEvent {}

class ShopStartedEvent extends ShopEvent {
  final String sellerId;

  ShopStartedEvent({required this.sellerId});
}

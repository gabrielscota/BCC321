part of '../controller/shop_information_bloc.dart';

abstract class ShopInformationEvent {}

class ShopInformationStartedEvent extends ShopInformationEvent {
  final String sellerId;
  final String shopName;
  final String description;

  ShopInformationStartedEvent({
    required this.sellerId,
    required this.shopName,
    required this.description,
  });
}

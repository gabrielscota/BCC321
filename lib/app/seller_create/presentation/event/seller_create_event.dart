part of '../controller/seller_create_bloc.dart';

abstract class SellerCreateEvent {}

class SellerCreateStartedEvent extends SellerCreateEvent {
  final String shopName;
  final String shopDescription;
  final String userId;

  SellerCreateStartedEvent({
    required this.shopName,
    required this.shopDescription,
    required this.userId,
  });
}

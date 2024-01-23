part of '../controller/seller_bloc.dart';

abstract class SellerEvent {}

class SellerStartedEvent extends SellerEvent {
  final String sellerId;

  SellerStartedEvent({required this.sellerId});
}

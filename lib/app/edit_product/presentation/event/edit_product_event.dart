part of '../controller/edit_product_bloc.dart';

abstract class EditProductEvent {}

class EditProductStartedEvent extends EditProductEvent {
  final String productId;
  final String description;
  final int stockQuantity;

  EditProductStartedEvent({
    required this.productId,
    required this.description,
    required this.stockQuantity,
  });
}

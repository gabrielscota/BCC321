part of '../controller/add_product_bloc.dart';

abstract class AddProductEvent {}

class AddProductLoadCategoriesEvent extends AddProductEvent {}

class AddProductStartedEvent extends AddProductEvent {
  final String name;
  final String description;
  final int price;
  final String categoryId;
  final int stockQuantity;
  final int sellerId;

  AddProductStartedEvent({
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.stockQuantity,
    required this.sellerId,
  });
}

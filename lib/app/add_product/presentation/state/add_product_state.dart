part of '../controller/add_product_bloc.dart';

abstract class AddProductState {}

class AddProductInitialState extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductLoadedState extends AddProductState {
  final List<CategoryEntity> categories;

  AddProductLoadedState({
    required this.categories,
  });
}

class AddProductSuccessfullState extends AddProductState {}

class AddProductErrorState extends AddProductState {
  final String message;

  AddProductErrorState({required this.message});
}

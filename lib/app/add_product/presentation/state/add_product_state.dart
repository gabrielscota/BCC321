part of '../controller/add_product_bloc.dart';

abstract class AddProductState {}

class AddProductInitialState extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductSuccessfullState extends AddProductState {}

class AddProductErrorState extends AddProductState {
  final String message;

  AddProductErrorState({required this.message});
}

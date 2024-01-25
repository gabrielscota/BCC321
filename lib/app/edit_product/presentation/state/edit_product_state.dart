part of '../controller/edit_product_bloc.dart';

abstract class EditProductState {}

class EditProductInitialState extends EditProductState {}

class EditProductLoadingState extends EditProductState {}

class EditProductSuccessfullState extends EditProductState {}

class EditProductErrorState extends EditProductState {
  final String message;

  EditProductErrorState({required this.message});
}

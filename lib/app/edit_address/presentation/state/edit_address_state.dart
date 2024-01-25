part of '../controller/edit_address_bloc.dart';

abstract class EditAddressState {}

class EditAddressInitialState extends EditAddressState {}

class EditAddressLoadingState extends EditAddressState {}

class EditAddressSuccessfullState extends EditAddressState {}

class EditAddressErrorState extends EditAddressState {
  final String message;

  EditAddressErrorState({required this.message});
}

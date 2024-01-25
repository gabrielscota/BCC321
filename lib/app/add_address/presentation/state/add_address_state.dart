part of '../controller/add_address_bloc.dart';

abstract class AddAddressState {}

class AddAddressInitialState extends AddAddressState {}

class AddAddressLoadingState extends AddAddressState {}

class AddAddressSuccessfullState extends AddAddressState {}

class AddAddressErrorState extends AddAddressState {
  final String message;

  AddAddressErrorState({required this.message});
}

part of '../controller/seller_create_bloc.dart';

abstract class SellerCreateState {}

class SellerCreateInitialState extends SellerCreateState {}

class SellerCreateLoadingState extends SellerCreateState {}

class SellerCreateSuccessfullState extends SellerCreateState {}

class SellerCreateErrorState extends SellerCreateState {
  final String message;

  SellerCreateErrorState({required this.message});
}

part of '../controller/shop_information_bloc.dart';

abstract class ShopInformationState {}

class ShopInformationInitialState extends ShopInformationState {}

class ShopInformationLoadingState extends ShopInformationState {}

class ShopInformationSuccessfullState extends ShopInformationState {}

class ShopInformationErrorState extends ShopInformationState {
  final String message;

  ShopInformationErrorState({required this.message});
}

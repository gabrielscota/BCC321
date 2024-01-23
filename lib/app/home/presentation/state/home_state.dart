part of '../controller/home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomePageLoadingState extends HomeState {}

class HomePageLoadedState extends HomeState {
  final UserEntity user;
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  final List<SellerEntity> sellers;

  HomePageLoadedState({
    required this.user,
    this.categories = const [],
    this.products = const [],
    this.sellers = const [],
  });
}

class HomePageErrorState extends HomeState {
  final String message;

  HomePageErrorState({required this.message});
}

class HomePageSignOutState extends HomeState {}

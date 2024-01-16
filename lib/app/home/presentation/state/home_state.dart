part of '../controller/home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomePageLoadingState extends HomeState {}

class HomePageLoadedState extends HomeState {
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;

  HomePageLoadedState({this.categories = const [], this.products = const []});
}

class HomePageErrorState extends HomeState {
  final String message;

  HomePageErrorState({required this.message});
}

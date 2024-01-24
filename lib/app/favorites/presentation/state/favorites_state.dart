part of '../controller/favorites_bloc.dart';

abstract class FavoritesState {}

class FavoritesInitialState extends FavoritesState {}

class FavoritesPageLoadingState extends FavoritesState {}

class FavoritesPageLoadedState extends FavoritesState {
  final List<ProductEntity> products;

  FavoritesPageLoadedState({this.products = const []});
}

class FavoritesPageErrorState extends FavoritesState {
  final String message;

  FavoritesPageErrorState({required this.message});
}

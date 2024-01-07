part of '../controller/product_details_bloc.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsPageLoadingState extends ProductDetailsState {}

class ProductDetailsPageLoadedState extends ProductDetailsState {}

class ProductDetailsPageErrorState extends ProductDetailsState {}

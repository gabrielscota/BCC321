part of '../controller/home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomePageLoadingState extends HomeState {}

class HomePageLoadedState extends HomeState {}

class HomePageErrorState extends HomeState {}

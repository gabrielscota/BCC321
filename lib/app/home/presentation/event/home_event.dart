part of '../controller/home_bloc.dart';

abstract class HomeEvent {}

class HomeStartedEvent extends HomeEvent {}

class HomeSignOutEvent extends HomeEvent {}

class HomeLoadUserDetailsEvent extends HomeEvent {}

class HomeVerifyIfUserIsSellerEvent extends HomeEvent {}

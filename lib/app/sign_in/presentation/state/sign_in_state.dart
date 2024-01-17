part of '../controller/sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessfullState extends SignInState {}

class SignInPageErrorState extends SignInState {
  final String message;

  SignInPageErrorState({required this.message});
}

part of '../controller/sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessfullState extends SignUpState {}

class SignUpPageErrorState extends SignUpState {
  final String message;

  SignUpPageErrorState({required this.message});
}

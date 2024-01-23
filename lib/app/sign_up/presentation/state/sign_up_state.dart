part of '../controller/sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessfullState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState({required this.message});
}

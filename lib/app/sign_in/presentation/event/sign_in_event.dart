part of '../controller/sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInStartedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInStartedEvent({required this.email, required this.password});
}

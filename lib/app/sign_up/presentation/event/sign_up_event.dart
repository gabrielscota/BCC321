part of '../controller/sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpStartedEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpStartedEvent({required this.email, required this.password});
}

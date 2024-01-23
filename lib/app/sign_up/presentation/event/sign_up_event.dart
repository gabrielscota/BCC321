part of '../controller/sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpStartedEvent extends SignUpEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String cpf;

  SignUpStartedEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.cpf,
  });
}

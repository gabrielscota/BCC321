part of '../controller/personal_information_bloc.dart';

abstract class PersonalInformationEvent {}

class PersonalInformationStartedEvent extends PersonalInformationEvent {
  final String userId;
  final String name;
  final String phone;

  PersonalInformationStartedEvent({
    required this.userId,
    required this.name,
    required this.phone,
  });
}

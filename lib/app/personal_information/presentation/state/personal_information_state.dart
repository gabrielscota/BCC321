part of '../controller/personal_information_bloc.dart';

abstract class PersonalInformationState {}

class PersonalInformationInitialState extends PersonalInformationState {}

class PersonalInformationLoadingState extends PersonalInformationState {}

class PersonalInformationSuccessfullState extends PersonalInformationState {}

class PersonalInformationErrorState extends PersonalInformationState {
  final String message;

  PersonalInformationErrorState({required this.message});
}

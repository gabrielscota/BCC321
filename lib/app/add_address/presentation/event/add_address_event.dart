part of '../controller/add_address_bloc.dart';

abstract class AddAddressEvent {}

class AddAddressStartedEvent extends AddAddressEvent {
  final String userId;
  final String city;
  final String state;
  final String number;
  final String street;
  final String country;
  final String zipCode;

  AddAddressStartedEvent({
    required this.userId,
    required this.city,
    required this.state,
    required this.number,
    required this.street,
    required this.country,
    required this.zipCode,
  });
}

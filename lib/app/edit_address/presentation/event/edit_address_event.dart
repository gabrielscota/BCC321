part of '../controller/edit_address_bloc.dart';

abstract class EditAddressEvent {}

class EditAddressStartedEvent extends EditAddressEvent {
  final String addressId;
  final String street;
  final String number;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  EditAddressStartedEvent({
    required this.addressId,
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });
}

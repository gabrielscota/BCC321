import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';

class AddressDto {
  final String id;
  final String street;
  final String number;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  AddressDto({
    required this.id,
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  factory AddressDto.fromMap(Map<String, dynamic> map) {
    try {
      return AddressDto(
        id: map['id'].toString(),
        street: map['street_address'] as String,
        number: map['number'] as String,
        city: map['city'] as String,
        state: map['state'] as String,
        country: map['country'] as String,
        zipCode: map['zip_code'] as String,
      );
    } catch (e) {
      throw DtoFailure(message: 'Error parsing address from map');
    }
  }

  factory AddressDto.empty() => AddressDto(
        id: '',
        street: '',
        number: '',
        city: '',
        state: '',
        country: '',
        zipCode: '',
      );

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      street: street,
      number: number,
      city: city,
      state: state,
      country: country,
      zipCode: zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'street_address': street,
      'number': number,
      'city': city,
      'state': state,
      'country': country,
      'zip_code': zipCode,
    };
  }
}

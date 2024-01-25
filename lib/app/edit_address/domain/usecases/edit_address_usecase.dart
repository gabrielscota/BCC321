import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class EditAddressUseCase {
  final EditAddressRepository repository;

  EditAddressUseCase({required this.repository});

  Future<Either<Failure, void>> call({required EditAddressUseCaseParams params}) async {
    try {
      await repository.editAddress(
        addressId: params.addressId,
        street: params.street,
        number: params.number,
        city: params.city,
        state: params.state,
        country: params.country,
        zipCode: params.zipCode,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class EditAddressUseCaseParams {
  final String addressId;
  final String street;
  final String number;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  EditAddressUseCaseParams({
    required this.addressId,
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });
}

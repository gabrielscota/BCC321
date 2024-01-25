import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class AddAddressUseCase {
  final AddAddressRepository repository;

  AddAddressUseCase({required this.repository});

  Future<Either<Failure, void>> call({required AddAddressUseCaseParams params}) async {
    try {
      await repository.addAddress(
        userId: params.userId,
        city: params.city,
        state: params.state,
        number: params.number,
        street: params.street,
        country: params.country,
        zipCode: params.zipCode,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class AddAddressUseCaseParams {
  final String userId;
  final String city;
  final String state;
  final String number;
  final String street;
  final String country;
  final String zipCode;

  AddAddressUseCaseParams({
    required this.userId,
    required this.city,
    required this.state,
    required this.number,
    required this.street,
    required this.country,
    required this.zipCode,
  });
}

import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class EditPersonalInformationUseCase {
  final EditPersonalInformationRepository repository;

  EditPersonalInformationUseCase({required this.repository});

  Future<Either<Failure, void>> call({required EditPersonalInformationUseCaseParams params}) async {
    try {
      await repository.editPersonalInformation(
        userId: params.userId,
        name: params.name,
        phone: params.phone,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class EditPersonalInformationUseCaseParams {
  final String userId;
  final String name;
  final String phone;

  EditPersonalInformationUseCaseParams({
    required this.userId,
    required this.name,
    required this.phone,
  });
}

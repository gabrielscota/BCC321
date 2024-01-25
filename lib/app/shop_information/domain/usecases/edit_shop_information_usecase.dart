import 'package:either_dart/either.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/repositories.dart';

class EditShopInformationUseCase {
  final EditShopInformationRepository repository;

  EditShopInformationUseCase({required this.repository});

  Future<Either<Failure, void>> call({required EditShopInformationUseCaseParams params}) async {
    try {
      await repository.editShopInformation(
        sellerId: params.sellerId,
        shopName: params.shopName,
        description: params.description,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

class EditShopInformationUseCaseParams {
  final String sellerId;
  final String shopName;
  final String description;

  EditShopInformationUseCaseParams({
    required this.sellerId,
    required this.shopName,
    required this.description,
  });
}

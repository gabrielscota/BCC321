import '../entities/entities.dart';

abstract class SellerDetailsRepository {
  Future<SellerEntity> fetchSellerDetails({required String sellerId});
}

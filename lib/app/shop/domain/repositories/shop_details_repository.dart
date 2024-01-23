import '../entities/entities.dart';

abstract class ShopDetailsRepository {
  Future<SellerEntity> fetchSellerDetails({required String sellerId});
}

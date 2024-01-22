import '../entities/entities.dart';

abstract class SellerProductRepository {
  Future<List<ProductEntity>> fetchProductList({required String sellerId});
}

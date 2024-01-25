import '../entities/entities.dart';

abstract class SellerProductsRepository {
  Future<List<ProductEntity>> fetchProductList({required String sellerId});
  Future<void> deleteProduct({required String productId});
}

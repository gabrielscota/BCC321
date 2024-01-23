import '../entities/entities.dart';

abstract class ShopProductRepository {
  Future<List<ProductEntity>> fetchProductList({required String sellerId});
}

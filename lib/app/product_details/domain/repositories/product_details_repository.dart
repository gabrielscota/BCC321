import '../entities/entities.dart';

abstract class ProductDetailsRepository {
  Future<ProductEntity> fetchProductDetails({required String userId, required String productId});
  Future<bool> favoriteProduct({required String userId, required String productId});
}

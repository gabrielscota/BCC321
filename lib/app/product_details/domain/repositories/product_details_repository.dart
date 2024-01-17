import '../entities/entities.dart';

abstract class ProductDetailsRepository {
  Future<ProductEntity> fetchProductDetails({required String productId});
}

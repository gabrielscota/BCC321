import '../entities/entities.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProductList({required String categoryId});
}

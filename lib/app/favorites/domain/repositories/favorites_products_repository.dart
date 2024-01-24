import '../entities/entities.dart';

abstract class FavoritesProductsRepository {
  Future<List<ProductEntity>> fetchProductList({required String userId});
}

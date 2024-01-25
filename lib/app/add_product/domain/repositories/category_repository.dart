import '../entities/entities.dart';

abstract class AddProductCategoryRepository {
  Future<List<CategoryEntity>> fetchCategoryList();
}

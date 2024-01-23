import '../entities/entities.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> fetchCategoryList();
}

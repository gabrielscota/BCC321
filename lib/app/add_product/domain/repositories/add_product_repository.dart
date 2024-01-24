abstract class AddProductRepository {
  Future<void> addProduct({
    required String name,
    required String description,
    required int price,
    required String categoryId,
    required int stockQuantity,
    required int sellerId,
  });
}

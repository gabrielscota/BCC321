abstract class EditProductRepository {
  Future<void> editProduct({required String productId, required String description, required int stockQuantity});
}

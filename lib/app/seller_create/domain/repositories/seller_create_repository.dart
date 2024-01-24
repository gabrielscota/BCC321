abstract class SellerCreateRepository {
  Future<void> createShop({
    required String shopName,
    required String shopDescription,
    required String userId,
  });
}

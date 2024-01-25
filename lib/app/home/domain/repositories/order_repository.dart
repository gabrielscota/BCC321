abstract class HomeOrderRepository {
  Future<void> newOrder({
    required List<Map<String, dynamic>> items,
    required String addressId,
    required String userId,
  });
}

import '../entities/entities.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> fetchOrderList({required String userId});
}

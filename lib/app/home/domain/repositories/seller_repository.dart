import '../entities/entities.dart';

abstract class SellerRepository {
  Future<List<SellerEntity>> fetchSellerList();
}

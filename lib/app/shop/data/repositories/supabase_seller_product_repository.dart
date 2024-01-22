import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseSellerProductRepository implements SellerProductRepository {
  final SupabaseClient client;

  SupabaseSellerProductRepository({required this.client});

  @override
  Future<List<ProductEntity>> fetchProductList({required String sellerId}) async {
    try {
      final response = await client.from('product').select().eq('seller_id', sellerId);
      if (response.isNotEmpty) {
        final products = response.map((e) => ProductDto.fromMap(e).toEntity()).toList();
        return products;
      } else {
        return [];
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseShopProductRepository implements ShopProductRepository {
  final SupabaseClient client;

  SupabaseShopProductRepository({required this.client});

  @override
  Future<List<ProductEntity>> fetchProductList({required String sellerId}) async {
    try {
      final response =
          await client.from('product').select().eq('seller_id', sellerId).order('created_at', ascending: false);
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

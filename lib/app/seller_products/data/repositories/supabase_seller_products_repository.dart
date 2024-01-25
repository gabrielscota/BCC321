import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseSellerProductsRepository implements SellerProductsRepository {
  final SupabaseClient client;

  SupabaseSellerProductsRepository({required this.client});

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
    } on PostgrestException catch (e) {
      if (e.code == '23503') {
        throw ApiFailure(message: 'Esse produto está em um pedido, não é possível excluí-lo');
      } else {
        throw ApiFailure(message: e.message);
      }
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }

  @override
  Future<void> deleteProduct({required String productId}) async {
    try {
      await client.from('product').delete().eq('id', productId);
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseAddProductRepository implements AddProductRepository {
  final SupabaseClient client;

  SupabaseAddProductRepository({required this.client});

  @override
  Future<void> addProduct({
    required String name,
    required String description,
    required int price,
    required String categoryId,
    required int stockQuantity,
    required int sellerId,
  }) async {
    try {
      await client.from('product').insert({
        'name': name,
        'description': description,
        'price': price,
        'category_id': categoryId,
        'stock_quantity': stockQuantity,
        'seller_id': sellerId,
      });
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

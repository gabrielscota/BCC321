import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseEditProductRepository implements EditProductRepository {
  final SupabaseClient client;

  SupabaseEditProductRepository({required this.client});

  @override
  Future<void> editProduct({required String productId, required String description, required int stockQuantity}) async {
    try {
      await client.from('product').update({
        'description': description,
        'stock_quantity': stockQuantity,
      }).eq('id', productId);
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

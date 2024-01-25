import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseOrderRepository implements HomeOrderRepository {
  final SupabaseClient client;

  SupabaseOrderRepository({required this.client});

  @override
  Future<void> newOrder({
    required List<Map<String, dynamic>> items,
    required String addressId,
    required String userId,
  }) async {
    try {
      final orderResponse = await client
          .from('order')
          .insert({
            'status': 'pending',
            'payment_method': 'cash',
            'delivery_date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
            'address_id': addressId,
            'user_id': userId,
          })
          .select()
          .single();

      if (orderResponse.isNotEmpty) {
        final orderId = orderResponse['id'] as int;

        for (final item in items) {
          await client.from('order_product').insert({
            'order_id': orderId,
            'product_id': item['id'],
            'quantity': item['quantity'],
            'price': item['price'],
          });
        }
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

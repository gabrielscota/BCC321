import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseOrdersRepository implements OrderRepository {
  final SupabaseClient client;

  SupabaseOrdersRepository({required this.client});

  @override
  Future<List<OrderEntity>> fetchOrderList({required String userId}) async {
    try {
      final response = await client.from('order').select().eq('user_id', userId);

      if (response.isNotEmpty) {
        final orders = response.map((e) => OrderDto.fromMap(e).toEntity()).toList();

        return orders;
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

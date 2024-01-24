import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseSellerCreateRepository implements SellerCreateRepository {
  final SupabaseClient client;

  SupabaseSellerCreateRepository({required this.client});

  @override
  Future<void> createShop({
    required String shopName,
    required String shopDescription,
    required String userId,
  }) async {
    try {
      await client.from('seller').insert(
        {
          'shop_name': shopName,
          'description': shopDescription,
          'user_id': userId,
        },
      );
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

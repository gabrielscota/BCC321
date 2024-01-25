import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseEditCouponRepository implements EditCouponRepository {
  final SupabaseClient client;

  SupabaseEditCouponRepository({required this.client});

  @override
  Future<void> editCoupon({
    required String couponId,
    required String discountCode,
    required double discountValue,
  }) async {
    try {
      await client.from('coupon').update({
        'discount_code': discountCode,
        'discount_value': discountValue,
      }).eq('id', couponId);
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

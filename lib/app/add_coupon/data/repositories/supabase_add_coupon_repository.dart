import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../../../shared/utils/utils.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseAddCouponRepository implements AddCouponRepository {
  final SupabaseClient client;

  SupabaseAddCouponRepository({required this.client});

  @override
  Future<void> addCoupon({
    required String discountCode,
    required double discountValue,
    required String startDate,
    required String endDate,
    required int sellerId,
  }) async {
    try {
      String? startDateIso;
      if (startDate.isNotEmpty) {
        startDateIso = AppDateFormat.convertBrazilianDateString(startDate).toIso8601String();
      } else {
        startDateIso = null;
      }

      String? endDateIso;
      if (endDate.isNotEmpty) {
        endDateIso = AppDateFormat.convertBrazilianDateString(endDate).toIso8601String();
      } else {
        endDateIso = null;
      }

      await client.from('coupon').insert({
        'discount_code': discountCode,
        'discount_value': discountValue,
        'start_date': startDateIso,
        'end_date': endDateIso,
        'seller_id': sellerId,
      });
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

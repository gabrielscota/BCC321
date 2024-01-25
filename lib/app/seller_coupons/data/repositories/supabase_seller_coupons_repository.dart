import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseSellerCouponsRepository implements SellerCouponsRepository {
  final SupabaseClient client;

  SupabaseSellerCouponsRepository({required this.client});

  @override
  Future<List<CouponEntity>> fetchCouponList({required String sellerId}) async {
    try {
      final response =
          await client.from('coupon').select().eq('seller_id', sellerId).order('created_at', ascending: false);
      if (response.isNotEmpty) {
        final products = response.map((e) => CouponDto.fromMap(e).toEntity()).toList();
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

  @override
  Future<void> deleteCoupon({required String couponId}) async {
    try {
      await client.from('coupon').delete().eq('id', couponId);
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

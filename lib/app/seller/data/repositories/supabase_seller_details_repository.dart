import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseSellerDetailsRepository implements SellerDetailsRepository {
  final SupabaseClient client;

  SupabaseSellerDetailsRepository({required this.client});

  @override
  Future<SellerEntity> fetchSellerDetails({required String sellerId}) async {
    try {
      final response = await client.from('seller').select().eq('user_id', sellerId).limit(1);
      if (response.isNotEmpty) {
        final seller = SellerDto.fromMap(response.first).toEntity();
        return seller;
      } else {
        throw ApiFailure(message: 'No seller found');
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

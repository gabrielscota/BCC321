import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseSellerRepository implements SellerRepository {
  final SupabaseClient client;

  SupabaseSellerRepository({required this.client});

  @override
  Future<List<SellerEntity>> fetchSellerList() async {
    try {
      final response = await client.from('seller').select();
      if (response.isNotEmpty) {
        final sellers = response.map((e) => SellerDto.fromMap(e).toEntity()).toList();
        return sellers;
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

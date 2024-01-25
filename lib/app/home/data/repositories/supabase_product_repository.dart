import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseProductRepository implements ProductRepository {
  final SupabaseClient client;

  SupabaseProductRepository({required this.client});

  @override
  Future<List<ProductEntity>> fetchProductList() async {
    try {
      final response = await client.from('product').select().order('created_at', ascending: false);
      if (response.isNotEmpty) {
        final products = response.map((e) => ProductDto.fromMap(e).toEntity()).toList();
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
}

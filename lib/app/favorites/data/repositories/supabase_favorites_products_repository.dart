import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseFavoritesProductsRepository implements FavoritesProductsRepository {
  final SupabaseClient client;

  SupabaseFavoritesProductsRepository({required this.client});

  @override
  Future<List<ProductEntity>> fetchProductList({required String userId}) async {
    try {
      final response = await client.from('favorite').select('product(*)').eq('user_id', userId);
      if (response.isNotEmpty) {
        final products = response.map((e) => ProductDto.fromMap(e['product']).toEntity()).toList();
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

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseProductDetailsRepository implements ProductDetailsRepository {
  final SupabaseClient client;

  SupabaseProductDetailsRepository({required this.client});

  @override
  Future<ProductEntity> fetchProductDetails({required String productId}) async {
    try {
      final response = await client.from('product').select().eq('id', productId);

      if (response.isNotEmpty) {
        final product = ProductDto.fromMap(response.first).toEntity();
        return product;
      } else {
        throw ApiFailure(message: 'Product not found');
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseProductDetailsRepository implements ProductDetailsRepository {
  final SupabaseClient client;

  SupabaseProductDetailsRepository({required this.client});

  @override
  Future<ProductEntity> fetchProductDetails({required String userId, required String productId}) async {
    try {
      final favoriteResponse =
          await client.from('favorite').select('id').eq('user_id', userId).eq('product_id', productId);
      final isFavorited = favoriteResponse.isNotEmpty;

      final ratingResponse = await client.from('rating').select('*').eq('product_id', productId);
      List<RatingDto> ratings = [];
      if (ratingResponse.isNotEmpty) {
        ratings = (ratingResponse).map((ratingData) {
          return RatingDto.fromMap(ratingData);
        }).toList();
      }

      final shopResponse = await client.from('product').select('seller(shop_name)').eq('id', productId).single();
      final shopName = shopResponse['seller']['shop_name'] as String;

      final productResponse = await client.from('product').select('*').eq('id', productId).single();
      if (productResponse.isNotEmpty) {
        productResponse.addAll({
          'is_favorited': isFavorited,
          'ratings': ratings,
          'shop_name': shopName,
        });
        final product = ProductDto.fromMap(productResponse).toEntity();
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

  @override
  Future<bool> favoriteProduct({required String userId, required String productId}) async {
    try {
      final favoriteProducts = await client.from('favorite').select().eq('product_id', productId).eq('user_id', userId);
      if (favoriteProducts.isNotEmpty) {
        await client.from('favorite').delete().eq('product_id', productId).eq('user_id', userId);
        return false;
      } else {
        await client.from('favorite').insert({
          'product_id': productId,
          'user_id': userId,
        });
        return true;
      }
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

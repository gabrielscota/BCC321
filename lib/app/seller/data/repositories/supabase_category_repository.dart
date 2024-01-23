import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseSellerCategoryRepository implements CategoryRepository {
  final SupabaseClient client;

  SupabaseSellerCategoryRepository({required this.client});

  @override
  Future<List<CategoryEntity>> fetchCategoryList() async {
    try {
      final response = await client.from('category').select();
      if (response.isNotEmpty) {
        final categories = response.map((e) => CategoryDto.fromMap(e).toEntity()).toList();
        return categories;
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

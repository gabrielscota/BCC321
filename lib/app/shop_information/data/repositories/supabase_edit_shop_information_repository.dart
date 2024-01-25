import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseEditShopInformationRepository implements EditShopInformationRepository {
  final SupabaseClient client;

  SupabaseEditShopInformationRepository({required this.client});

  @override
  Future<void> editShopInformation(
      {required String sellerId, required String shopName, required String description}) async {
    try {
      await client.from('seller').update({
        'shop_name': shopName,
        'description': description,
      }).eq('user_id', sellerId);
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

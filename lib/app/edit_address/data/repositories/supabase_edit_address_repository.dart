import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseEditAddressRepository implements EditAddressRepository {
  final SupabaseClient client;

  SupabaseEditAddressRepository({required this.client});

  @override
  Future<void> editAddress({
    required String addressId,
    required String street,
    required String number,
    required String city,
    required String state,
    required String country,
    required String zipCode,
  }) async {
    try {
      await client.from('address').update({
        'street_address': street,
        'number': number,
        'city': city,
        'state': state,
        'country': country,
        'zip_code': zipCode,
      }).eq('id', addressId);
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

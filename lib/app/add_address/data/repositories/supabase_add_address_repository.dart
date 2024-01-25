import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseAddAddressRepository implements AddAddressRepository {
  final SupabaseClient client;

  SupabaseAddAddressRepository({required this.client});

  @override
  Future<void> addAddress({
    required String userId,
    required String city,
    required String state,
    required String number,
    required String street,
    required String country,
    required String zipCode,
  }) async {
    try {
      final addressResponse = await client.from('address').insert({
        'city': city,
        'state': state,
        'number': number,
        'street_address': street,
        'country': country,
        'zip_code': zipCode,
      }).select();

      if (addressResponse.isNotEmpty) {
        final addressId = addressResponse.first['id'] as int;
        await client.from('user').update({'address_id': addressId}).eq('id', userId);
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

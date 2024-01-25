import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseEditPersonalInformationRepository implements EditPersonalInformationRepository {
  final SupabaseClient client;

  SupabaseEditPersonalInformationRepository({required this.client});

  @override
  Future<void> editPersonalInformation({required String userId, required String name, required String phone}) async {
    try {
      await client.from('user').update({'name': name, 'phone': phone}).eq('id', userId);
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

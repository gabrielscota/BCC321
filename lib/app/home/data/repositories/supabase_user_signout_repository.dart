import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseUserSignOutRepository implements UserSignOutRepository {
  final SupabaseClient client;

  SupabaseUserSignOutRepository({required this.client});

  @override
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

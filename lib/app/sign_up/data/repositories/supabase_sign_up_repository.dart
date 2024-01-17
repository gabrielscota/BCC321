import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';

class SupabaseSignUpRepository implements SignUpRepository {
  final SupabaseClient client;

  SupabaseSignUpRepository({required this.client});

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {}
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseUserDetailsRepository implements UserDetailsRepository {
  final SupabaseClient client;

  SupabaseUserDetailsRepository({required this.client});

  @override
  Future<UserEntity> fetchUserDetails() async {
    try {
      final userUUID = client.auth.currentUser?.id;

      final response = await client.from('user').select().eq('uuid', userUUID ?? '').limit(1);
      if (response.isNotEmpty) {
        final user = UserDto.fromMap(response.first).toEntity();
        return user;
      } else {
        throw ApiFailure(message: 'No user found');
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }

  @override
  Future<bool> verifyIfUserIsSeller({required String userId}) async {
    try {
      final response = await client.from('seller').select().eq('user_id', userId).limit(1);
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

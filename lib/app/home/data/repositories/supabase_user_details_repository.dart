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
        response.first['cpf'] = '';
        response.first['cnpj'] = '';

        final physicalPersonResponse =
            await client.from('person_physical').select().eq('user_id', response.first['id']).limit(1);
        if (physicalPersonResponse.isNotEmpty) {
          response.first['cpf'] = physicalPersonResponse.first['cpf'];
        } else {
          final legalPersonResponse =
              await client.from('person_legal').select().eq('user_id', response.first['id']).limit(1);
          if (legalPersonResponse.isNotEmpty) {
            response.first['cnpj'] = legalPersonResponse.first['cnpj'];
          }
        }

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

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class SupabaseSignUpRepository implements SignUpRepository {
  final SupabaseClient client;

  SupabaseSignUpRepository({required this.client});

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required bool isPhysicalPerson,
    required String cpf,
    required String cnpj,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final userResult = await client.from('user').insert({
          'name': name,
          'email': email,
          'phone': phone,
          'uuid': response.user!.id,
        }).select();

        final user = UserDto.fromMap(userResult.first);

        if (isPhysicalPerson) {
          final physicalPersonUser = PhysicalPersonUserDto(
            user: user,
            cpf: cpf,
          ).toMap();
          await client.from('person_physical').insert(physicalPersonUser);
        } else {
          final legalPersonUser = LegalPersonUserDto(
            user: user,
            cnpj: cnpj,
          ).toMap();
          await client.from('person_legal').insert(legalPersonUser);
        }

        await client.auth.signInWithPassword(
          email: user.email,
          password: password,
        );
      }
    } on DtoFailure catch (_) {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}

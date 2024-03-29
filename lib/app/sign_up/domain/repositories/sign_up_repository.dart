abstract class SignUpRepository {
  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required bool isPhysicalPerson,
    required String cpf,
    required String cnpj,
  });
}

abstract class AddAddressRepository {
  Future<void> addAddress({
    required String userId,
    required String city,
    required String state,
    required String number,
    required String street,
    required String country,
    required String zipCode,
  });
}

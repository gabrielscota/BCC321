abstract class EditAddressRepository {
  Future<void> editAddress({
    required String addressId,
    required String street,
    required String number,
    required String city,
    required String state,
    required String country,
    required String zipCode,
  });
}

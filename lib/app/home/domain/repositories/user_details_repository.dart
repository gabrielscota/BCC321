import '../entities/entities.dart';

abstract class UserDetailsRepository {
  Future<UserEntity> fetchUserDetails();
  Future<bool> verifyIfUserIsSeller({required String userId});
}

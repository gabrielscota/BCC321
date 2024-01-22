import '../entities/entities.dart';

abstract class UserDetailsRepository {
  Future<UserEntity> fetchUserDetails();
}

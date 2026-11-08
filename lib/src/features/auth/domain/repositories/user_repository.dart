import 'package:jdonuts/src/features/auth/domain/domain.dart';

abstract interface class IUserRepository {
  Future<UserEntity> getMe();
  Future<UserEntity?> getSavedUserInfo();
  Future<void> saveUserInfo(UserEntity user);
  Future<void> deleteUserInfo();

  Future<UserEntity> updateUserInfo({
    required String id,
    String? name,
    String? password,
    String? profilePicturePath,
    DateTime? dateOfBirth,
  });
}

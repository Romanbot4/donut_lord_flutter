import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

@Injectable(as: IUserRepository, env: [AuthConfig.remote])
class RemoteUserRepository implements IUserRepository {
  final AuthApiClient _userApiClient;
  final IUserLocalStorage _userLocalStorage;
  const RemoteUserRepository(this._userApiClient, this._userLocalStorage);

  @override
  Future<UserEntity> getMe() {
    return _userApiClient.getMe();
  }

  @override
  Future<UserEntity?> getSavedUserInfo() =>
      _userLocalStorage.getSavedUserInfo();

  @override
  Future<void> saveUserInfo(UserEntity user) =>
      _userLocalStorage.saveUserInfo(user);

  @override
  Future<void> deleteUserInfo() => _userLocalStorage.deleteUserInfo();

  @override
  Future<UserEntity> updateUserInfo({
    required String id,
    String? name,
    String? password,
    String? profilePicturePath,
    DateTime? dateOfBirth,
  }) {
    File? profilePictureFile;
    if (profilePicturePath != null && profilePicturePath.isNotEmpty) {
      profilePictureFile = File(profilePicturePath);
    }
    return withMinimumDuration(
      _userApiClient.updateUserInfo(
        id,
        name,
        password,
        profilePictureFile,
        dateOfBirth == null ? null : _isoDate(dateOfBirth),
      ),
      NetworkConfig.authStepMinimumDuration,
    );
  }

  static String _isoDate(DateTime date) =>
      date.toIso8601String().split('T').first;
}

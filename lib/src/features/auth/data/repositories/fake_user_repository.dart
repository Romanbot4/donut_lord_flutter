import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@Injectable(as: IUserRepository, env: [AuthConfig.fake])
class FakeUserRepository implements IUserRepository {
  final FakeUserStore _users;
  final IUserLocalStorage _userLocalStorage;
  const FakeUserRepository(this._users, this._userLocalStorage);

  @override
  Future<UserEntity> getMe() async {
    final saved = await _userLocalStorage.getSavedUserInfo();
    final user = saved == null ? null : await _users.findById(saved.id);
    if (user == null) throw const AuthRequiredError();
    return user;
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
  }) async {
    await Future.delayed(AuthConfig.fakeStepDelay);
    final user = await _users.findById(id);
    if (user == null) throw const NotFoundError('User not found');

    final updated = user.copyWith(
      name: name?.trim() ?? user.name,
      dateOfBirth: dateOfBirth ?? user.dateOfBirth,
    );
    await _users.save(updated);
    return updated;
  }
}

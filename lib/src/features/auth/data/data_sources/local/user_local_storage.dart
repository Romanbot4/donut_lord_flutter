import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

abstract interface class IUserLocalStorage {
  Future<UserEntity?> getSavedUserInfo();
  Future<void> saveUserInfo(UserEntity user);
  Future<void> deleteUserInfo();
}

@Injectable(as: IUserLocalStorage)
class UserLocalStorage implements IUserLocalStorage {
  final ISecureStorage _localStorage;
  const UserLocalStorage(this._localStorage);

  static const String _userStorageKey = "USER_INFO";

  @override
  Future<UserEntity?> getSavedUserInfo() async {
    final source = await _localStorage.getString(_userStorageKey);
    if (source == null) return null;
    return UserModel.fromJson(json.decode(source));
  }

  @override
  Future<void> saveUserInfo(UserEntity user) async {
    await _localStorage.setString(
      _userStorageKey,
      json.encode(UserModel.fromEntity(user).toJson()),
    );
  }

  @override
  Future<void> deleteUserInfo() async {
    await _localStorage.remove(_userStorageKey);
  }
}

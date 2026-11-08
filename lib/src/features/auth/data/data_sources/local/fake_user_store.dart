import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@LazySingleton(env: [AuthConfig.fake])
class FakeUserStore {
  final ILocalStorage _storage;
  const FakeUserStore(this._storage);

  static const _usersStorageKey = "FAKE_USERS";

  Future<UserModel?> findByIdentifier(String identifier) async {
    return (await _readAll())[identifier];
  }

  Future<UserModel?> findById(String id) async {
    final users = (await _readAll()).values;
    return users.where((user) => user.id == id).firstOrNull;
  }

  Future<UserModel> findOrCreate(String identifier) async {
    final users = await _readAll();
    final existing = users[identifier];
    if (existing != null) return existing;

    final user = UserModel(
      id: '${users.length + 1}',
      name: '',
      identifier: identifier,
    );
    await save(user);
    return user;
  }

  Future<void> save(UserModel user) async {
    final users = await _readAll()
      ..[user.identifier] = user;
    await _storage.setString(
      _usersStorageKey,
      json.encode(users.map((key, value) => MapEntry(key, value.toJson()))),
    );
  }

  Future<Map<String, UserModel>> _readAll() async {
    final source = await _storage.getString(_usersStorageKey);
    if (source == null) return {};
    final decoded = json.decode(source) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(key, UserModel.fromJson(value)),
    );
  }
}

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

abstract interface class IAuthTokenStore {
  AuthToken? get current;

  Future<void> save(AuthToken token);

  Future<bool> clear();
}

class AuthTokenStore implements IAuthTokenStore {
  final ISecureStorage _storage;
  AuthTokenStore(this._storage);

  static const _tokenStorageKey = "TOKEN";

  AuthToken? _current;

  @override
  AuthToken? get current => _current;

  Future<void> load() async {
    final source = await _storage.getString(_tokenStorageKey);
    if (source == null) return;
    _current = TokenResponse.fromJson(json.decode(source));
  }

  @override
  Future<void> save(AuthToken token) async {
    _current = token;
    await _storage.setString(
      _tokenStorageKey,
      json.encode(TokenResponse.fromEntity(token).toJson()),
    );
  }

  @override
  Future<bool> clear() async {
    final hadToken = _current != null;
    _current = null;
    await _storage.remove(_tokenStorageKey);
    return hadToken;
  }
}

@module
abstract class AuthTokenStoreProvider {
  @preResolve
  @singleton
  Future<IAuthTokenStore> provide(ISecureStorage storage) async {
    final store = AuthTokenStore(storage);
    await store.load();
    return store;
  }
}

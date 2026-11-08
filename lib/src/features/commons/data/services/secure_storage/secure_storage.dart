import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

/// [ISecureStorage] from flutter_secure_storage
@LazySingleton(as: ISecureStorage)
class SecureStorage implements ISecureStorage {
  final FlutterSecureStorage _storage;
  const SecureStorage(this._storage);

  static const _true = 'true';
  static const _false = 'false';

  @override
  Future<String?> getString(String key) => _storage.read(key: key);

  @override
  Future<bool> setString(String key, String? value) async {
    if (value == null) return remove(key);
    await _storage.write(key: key, value: value);
    return true;
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    final source = await _storage.read(key: key);
    if (source == null) return null;
    try {
      return (json.decode(source) as List<dynamic>).cast<String>();
    } on FormatException {
      return null;
    }
  }

  @override
  Future<bool> setStringList(String key, List<String>? value) async {
    if (value == null) return remove(key);
    await _storage.write(key: key, value: json.encode(value));
    return true;
  }

  @override
  Future<bool?> getBool(String key) async =>
      switch (await _storage.read(key: key)) {
        _true => true,
        _false => false,
        _ => null,
      };

  @override
  Future<bool> setBool(String key, bool? value) async {
    if (value == null) return remove(key);
    await _storage.write(key: key, value: value ? _true : _false);
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    await _storage.delete(key: key);
    return true;
  }
}

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ILocalStorage)
class LocalStorage implements ILocalStorage {
  final SharedPreferences _storage;
  const LocalStorage(this._storage);

  @override
  Future<bool?> getBool(String key) async {
    return _storage.getBool(key);
  }

  @override
  Future<String?> getString(String key) async {
    return _storage.getString(key);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return _storage.getStringList(key);
  }

  @override
  Future<bool> setBool(String key, bool? value) async {
    if (value == null) return await remove(key);
    return await _storage.setBool(key, value);
  }

  @override
  Future<bool> setString(String key, String? value) async {
    if (value == null) return await remove(key);
    return await _storage.setString(key, value);
  }

  @override
  Future<bool> setStringList(String key, List<String>? value) async {
    if (value == null) return await remove(key);
    return await _storage.setStringList(key, value);
  }

  @override
  Future<bool> remove(String key) async {
    return await _storage.remove(key);
  }
}

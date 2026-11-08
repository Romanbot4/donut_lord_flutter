abstract interface class ILocalStorage {
  Future<bool> remove(String key);

  Future<String?> getString(String key);

  Future<bool> setString(String key, String? value);

  Future<List<String>?> getStringList(String key);

  Future<bool> setStringList(String key, List<String>? value);

  Future<bool?> getBool(String key);

  Future<bool> setBool(String key, bool? value);
}

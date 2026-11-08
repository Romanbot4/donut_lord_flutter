import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

abstract interface class IAppSettingLocalStorage {
  Future<ThemeMode?> getSavedTheme();
  Future<void> saveTheme(ThemeMode themeMode);
}

@Injectable(as: IAppSettingLocalStorage)
class AppSettingLocalStorage implements IAppSettingLocalStorage {
  final ILocalStorage _localStorage;
  const AppSettingLocalStorage(this._localStorage);

  static const String _themeStorageKey = "THEME";

  @override
  Future<ThemeMode?> getSavedTheme() async {
    final source = await _localStorage.getString(_themeStorageKey);
    if (source == null) return null;
    return ThemeModeMapper.parse(source);
  }

  @override
  Future<void> saveTheme(ThemeMode themeMode) async {
    await _localStorage.setString(_themeStorageKey, themeMode.name.toString());
  }
}

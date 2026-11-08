import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@Injectable(as: IThemeRepository)
class ThemeRepository implements IThemeRepository {
  final IAppSettingLocalStorage _appSettingLocalStorage;
  const ThemeRepository(this._appSettingLocalStorage);

  @override
  Future<ThemeMode?> getSavedTheme() => _appSettingLocalStorage.getSavedTheme();

  @override
  Future<void> saveTheme(ThemeMode themeMode) =>
      _appSettingLocalStorage.saveTheme(themeMode);
}

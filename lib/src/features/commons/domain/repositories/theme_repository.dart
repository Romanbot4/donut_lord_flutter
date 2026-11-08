import 'package:flutter/material.dart';

abstract interface class IThemeRepository {
  Future<ThemeMode?> getSavedTheme();
  Future<void> saveTheme(ThemeMode themeMode);
}

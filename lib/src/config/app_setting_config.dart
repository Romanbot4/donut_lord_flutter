import 'package:flutter/material.dart';

abstract class AppSettingConfig {
  static const ThemeMode defaultThemeMode = ThemeMode.light;
  static const Locale defaultLocale = Locale("en");

  static const String deepLinkScheme = "romanbot4";
}

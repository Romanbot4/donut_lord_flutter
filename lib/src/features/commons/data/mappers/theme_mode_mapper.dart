import 'package:flutter/material.dart';

abstract class ThemeModeMapper {
  static ThemeMode? parse(String value) {
    switch (value) {
      case "dark":
        return ThemeMode.dark;
      case "light":
        return ThemeMode.light;
      case "system":
        return ThemeMode.system;
      default:
        return null;
    }
  }
}

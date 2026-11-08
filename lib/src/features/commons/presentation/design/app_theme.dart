import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  final BuildContext context;
  final Locale? locale;
  const AppTheme(this.context, {this.locale});

  static const _lightColorScheme = ColorScheme(
    surfaceTint: AppColors.transparent,
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.offWhite,
    onSurface: AppColors.black,
  );

  static const _darkColorScheme = ColorScheme(
    surfaceTint: AppColors.transparent,
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.darkGrey,
    onSurface: AppColors.white,
  );

  AppTypography get _typography =>
      AppTypography(locale ?? Localizations.maybeLocaleOf(context));

  ThemeData get light {
    final textTheme = _typography.light;
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: textTheme,
    ).copyWith(
      primaryColor: _lightColorScheme.primary,
      scaffoldBackgroundColor: AppColors.softGrey,
      cardColor: AppColors.white,
      textTheme: textTheme,
    );
  }

  ThemeData get dark {
    final textTheme = _typography.dark;
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: textTheme,
    ).copyWith(
      primaryColor: _darkColorScheme.primary,
      scaffoldBackgroundColor: AppColors.offBlack,
      cardColor: AppColors.darkGrey,
      textTheme: textTheme,
    );
  }
}

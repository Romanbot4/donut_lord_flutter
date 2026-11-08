import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  final Locale? _locale;
  AppTypography(this._locale);

  static const ffEnglish = "General Sans";
  static const ffUnicode = "Noto Sans Myanmar";
  static const ffDisplay = "Menco";

  static const _defaultTextColor = AppColors.neutral900;
  static const _mutedTextColor = AppColors.neutral600;
  static const _buttonLetterSpacing = 1.2;

  bool get _isMyanmar => _locale?.languageCode == "my";

  late final ffPrimary = _isMyanmar ? ffUnicode : ffEnglish;

  late final ffHeading = _isMyanmar ? ffUnicode : ffDisplay;

  late final _fallbackFonts = [ffEnglish, ffUnicode];

  TextStyle _style({
    required String fontFamily,
    required double fontSize,
    required double lineHeight,
    required FontWeight fontWeight,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontFamilyFallback: _fallbackFonts,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: _defaultTextColor,
    );
  }

  late final display1 = _style(
    fontFamily: ffHeading,
    fontSize: 40,
    lineHeight: 48,
    fontWeight: FontWeight.w700,
  );

  late final display2 = _style(
    fontFamily: ffHeading,
    fontSize: 36,
    lineHeight: 44,
    fontWeight: FontWeight.w700,
  );

  late final display3 = _style(
    fontFamily: ffHeading,
    fontSize: 32,
    lineHeight: 40,
    fontWeight: FontWeight.w700,
  );
  late final heading1 = _style(
    fontFamily: ffHeading,
    fontSize: 28,
    lineHeight: 34,
    fontWeight: FontWeight.w700,
  );

  late final heading2 = _style(
    fontFamily: ffHeading,
    fontSize: 24,
    lineHeight: 30,
    fontWeight: FontWeight.w700,
  );

  late final heading3 = _style(
    fontFamily: ffHeading,
    fontSize: 20,
    lineHeight: 26,
    fontWeight: FontWeight.w700,
  );

  late final title1 = _style(
    fontFamily: ffHeading,
    fontSize: 18,
    lineHeight: 24,
    fontWeight: FontWeight.w500,
  );

  late final title2 = _style(
    fontFamily: ffPrimary,
    fontSize: 16,
    lineHeight: 22,
    fontWeight: FontWeight.w600,
  );

  late final title3 = _style(
    fontFamily: ffPrimary,
    fontSize: 14,
    lineHeight: 20,
    fontWeight: FontWeight.w600,
  );

  late final paragraph1 = _style(
    fontFamily: ffPrimary,
    fontSize: 16,
    lineHeight: 24,
    fontWeight: FontWeight.w400,
  );

  late final paragraph2 = _style(
    fontFamily: ffPrimary,
    fontSize: 14,
    lineHeight: 20,
    fontWeight: FontWeight.w400,
  );

  late final paragraph3 = _style(
    fontFamily: ffPrimary,
    fontSize: 12,
    lineHeight: 16,
    fontWeight: FontWeight.w400,
  );

  late final label1 = _style(
    fontFamily: ffPrimary,
    fontSize: 14,
    lineHeight: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: _buttonLetterSpacing,
  );

  late final label2 = _style(
    fontFamily: ffPrimary,
    fontSize: 12,
    lineHeight: 16,
    fontWeight: FontWeight.w600,
  );

  late final label3 = _style(
    fontFamily: ffPrimary,
    fontSize: 10,
    lineHeight: 14,
    fontWeight: FontWeight.w400,
  );

  late final _defaultTextOverFlow = TextOverflow.ellipsis;

  late final _baseTextTheme = ThemeData(
    useMaterial3: true,
    fontFamily: ffPrimary,
    fontFamilyFallback: _fallbackFonts,
  ).textTheme;

  TextStyle _themed(TextStyle style, {Color? color}) {
    return style.copyWith(overflow: _defaultTextOverFlow, color: color);
  }

  late final light = _baseTextTheme.copyWith(
    displayLarge: _themed(display1),
    displayMedium: _themed(display2),
    displaySmall: _themed(display3),
    headlineLarge: _themed(heading1),
    headlineMedium: _themed(heading2),
    headlineSmall: _themed(heading3),
    titleLarge: _themed(title1),
    titleMedium: _themed(title2),
    titleSmall: _themed(title3),
    bodyLarge: _themed(paragraph1),
    bodyMedium: _themed(paragraph2),
    bodySmall: _themed(paragraph3, color: _mutedTextColor),
    labelLarge: _themed(label1),
    labelMedium: _themed(label2),
    labelSmall: _themed(label3, color: _mutedTextColor),
  );

  late final dark = light
      .apply(bodyColor: AppColors.white, displayColor: AppColors.white)
      .copyWith(
        bodySmall: light.bodySmall?.copyWith(color: AppColors.neutral300),
        labelSmall: light.labelSmall?.copyWith(color: AppColors.neutral300),
      );
}

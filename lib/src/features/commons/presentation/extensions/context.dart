import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

extension ThemeDataExtension on ThemeData {
  bool get isDark => brightness == Brightness.dark;
}

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  /// Same [ILocalization.localizationsDelegates])
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  NavigatorState get navigator => Navigator.of(this);

  MediaQueryData get mediaQueryPlatform => MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  );

  FlutterView get view => View.of(this);

  double get textScaleFactor => mediaQuery.textScaler.scale(1);

  double get pixelRatio => view.devicePixelRatio;
  Display get display => view.display;

  double get width => mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  static const _fallbackFontSize = 14.0;
  static const _fallbackLineHeightFactor = 1.2;

  double lineHeight(TextStyle? style, {int lines = 1}) {
    final fontSize = style?.fontSize ?? _fallbackFontSize;
    final height = style?.height ?? _fallbackLineHeightFactor;
    return (MediaQuery.textScalerOf(this).scale(fontSize) * height * lines)
        .ceilToDouble();
  }

  bool canPop() => Navigator.of(this).canPop();

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
}

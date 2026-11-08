import 'package:flutter/widgets.dart';
import 'package:jdonuts/src/core/core.dart';

import 'i18n/app_localizations.dart';

abstract class ILocalization {
  Locale get fallbackLocale;

  bool _isInitialized = false;
  late Locale _locale;
  late AppLocalizations _localizations;

  Locale get localeEnUs;
  Locale get localeMyMm;

  Locale get locale => _isInitialized
      ? _locale
      : throw InvalidOperationError(
          "ILocalizations service hasn't initialized yet",
        );

  AppLocalizations get localizations => _isInitialized
      ? _localizations
      : throw InvalidOperationError(
          "ILocalizations service hasn't initialized yet",
        );

  Future<Locale?> loadSavedLocale();
  Future<void> changeLocale(Locale locale);
  Future<Locale> provideEffectiveLocaleForInitialization();

  Future<void> initialize() async {
    _locale = await provideEffectiveLocaleForInitialization();
    _localizations = await AppLocalizations.delegate.load(_locale);
    _isInitialized = true;
  }

  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  List<LocalizationsDelegate> get localizationsDelegates =>
      AppLocalizations.localizationsDelegates;
}

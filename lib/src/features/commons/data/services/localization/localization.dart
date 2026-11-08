import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl_standalone.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

import 'mappers/locale_mapper.dart';
import 'models/locale_model.dart';

class Localization extends ILocalization {
  final ILocalStorage _localStorage;
  Localization(this._localStorage);

  @override
  late final localeEnUs = const Locale('en', 'US');
  @override
  late final localeMyMm = const Locale('my', 'MM');

  static const String _localeStorageKey = "Localization_Saved_Locale";

  @override
  Future<void> changeLocale(Locale updateLocale) async {
    await saveLocale(updateLocale);
    if (updateLocale != locale) await initialize();
  }

  @override
  Locale get fallbackLocale => localeEnUs;

  @override
  Future<Locale?> loadSavedLocale() async {
    final String? source = await _localStorage.getString(_localeStorageKey);
    if (source == null) return null;

    return LocaleModel.fromJson(json.decode(source)).toEntity();
  }

  Future<Locale?> loadSystemLocale() async {
    final systemLocale = await findSystemLocale();
    return LocaleMapper.fromSystemLocaleString(systemLocale);
  }

  @override
  Future<Locale> provideEffectiveLocaleForInitialization() async {
    final savedLocale = await loadSavedLocale();
    final candidateLocale = savedLocale ?? fallbackLocale;
    final isCandidateLocaleContains = supportedLocales.any(
      (e) => e.languageCode == candidateLocale.languageCode,
    );
    final effectiveLocale = isCandidateLocaleContains
        ? candidateLocale
        : fallbackLocale;

    return effectiveLocale;
  }

  Future<void> saveLocale(Locale locale) async {
    await _localStorage.setString(
      _localeStorageKey,
      json.encode(LocaleModel.fromEntity(locale).toJson()),
    );
  }
}

import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_model.freezed.dart';
part 'locale_model.g.dart';

@freezed
sealed class LocaleModel with _$LocaleModel {
  const factory LocaleModel(String languageCode, [String? countryCode]) =
      _LocaleModel;

  factory LocaleModel.fromJson(Map<String, dynamic> json) =>
      _$LocaleModelFromJson(json);

  factory LocaleModel.fromEntity(Locale locale) =>
      LocaleModel(locale.languageCode, locale.countryCode);
}

extension LocaleModelMapper on LocaleModel {
  Locale toEntity() => Locale(languageCode, countryCode);
}

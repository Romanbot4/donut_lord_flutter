import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@injectable
class GetLocaleUsecase extends UseCase<Locale?, void> {
  final ILocalization _localization;
  const GetLocaleUsecase(this._localization);

  @override
  Future<Locale?> handle([void param]) async {
    return await _localization.loadSavedLocale();
  }
}

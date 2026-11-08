import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@injectable
class GetThemeUsecase extends UseCase<ThemeMode?, void> {
  final IThemeRepository _repository;
  const GetThemeUsecase(this._repository);

  @override
  Future<ThemeMode?> handle([void param]) async {
    return await _repository.getSavedTheme();
  }
}

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

@module
abstract class LocalizationProvider {
  @preResolve
  @lazySingleton
  Future<ILocalization> provide(ILocalStorage localStorage) async {
    final localization = Localization(localStorage);
    await localization.initialize();
    return localization;
  }
}

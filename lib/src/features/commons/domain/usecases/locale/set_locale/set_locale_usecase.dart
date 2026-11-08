import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@injectable
class SetLocaleUsecase extends UseCase<void, SetLocaleParam> {
  final ILocalization _localization;
  const SetLocaleUsecase(this._localization);

  @override
  Future<void> handle(SetLocaleParam param) async {
    return await _localization.changeLocale(param.locale);
  }
}

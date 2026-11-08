import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@injectable
class SetThemeUsecase extends UseCase<void, SetThemeParam> {
  final IThemeRepository _repository;
  const SetThemeUsecase(this._repository);

  @override
  Future<void> handle(SetThemeParam param) async {
    await _repository.saveTheme(param.themeMode);
  }
}

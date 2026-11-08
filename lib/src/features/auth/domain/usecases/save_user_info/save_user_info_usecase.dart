import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class SaveUserInfoUseCase extends UseCase<void, SaveUserInfoParam> {
  final IUserRepository _repository;
  const SaveUserInfoUseCase(this._repository);

  @override
  Future<void> handle(SaveUserInfoParam param) {
    return _repository.saveUserInfo(param.user);
  }
}

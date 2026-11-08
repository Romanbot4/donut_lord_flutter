import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class GetMeUseCase extends UseCase<UserEntity, void> {
  final IUserRepository _repository;
  const GetMeUseCase(this._repository);

  @override
  Future<UserEntity> handle(void param) async {
    final user = await _repository.getMe();
    await _repository.saveUserInfo(user);
    return user;
  }
}

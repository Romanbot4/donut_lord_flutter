import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class UpdateUserInfoUseCase extends UseCase<UserEntity, UpdateUserInfoParam> {
  final IUserRepository _repository;
  const UpdateUserInfoUseCase(this._repository);

  @override
  Future<UserEntity> handle(UpdateUserInfoParam param) async {
    final user = await _repository.updateUserInfo(
      id: param.id,
      name: param.name,
      password: param.password,
      profilePicturePath: param.profilePicturePath,
      dateOfBirth: param.dateOfBirth,
    );
    await _repository.saveUserInfo(user);
    return user;
  }
}

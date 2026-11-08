import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class GetSavedUserUseCase extends UseCase<UserEntity?, void> {
  final IUserRepository _repository;
  const GetSavedUserUseCase(this._repository);

  @override
  Future<UserEntity?> handle(void param) => _repository.getSavedUserInfo();
}

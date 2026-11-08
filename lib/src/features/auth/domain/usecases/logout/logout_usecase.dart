import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class LogOutUseCase extends UseCase<void, void> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  const LogOutUseCase(this._authRepository, this._userRepository);

  @override
  Future<void> handle(void param) async {
    await _authRepository.deleteToken();
    await _userRepository.deleteUserInfo();
  }
}

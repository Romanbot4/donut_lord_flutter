import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class VerifyOtpUseCase extends UseCase<AuthorizedResult, VerifyOtpParam> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  const VerifyOtpUseCase(this._authRepository, this._userRepository);

  @override
  Future<AuthorizedResult> handle(VerifyOtpParam param) async {
    final result = await _authRepository.verifyOtp(
      identifier: param.identifier,
      code: param.code,
    );

    await _authRepository.saveToken(result.token);
    await _userRepository.saveUserInfo(result.userInfo);
    return result;
  }
}

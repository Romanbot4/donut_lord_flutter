import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class SendOtpUseCase extends UseCase<SendOtpResult, SendOtpParam> {
  final IAuthRepository _repository;
  const SendOtpUseCase(this._repository);

  @override
  Future<SendOtpResult> handle(SendOtpParam param) {
    return _repository.sendOtp(identifier: param.identifier);
  }
}

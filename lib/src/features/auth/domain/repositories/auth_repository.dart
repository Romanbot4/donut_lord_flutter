import 'package:jdonuts/src/features/auth/domain/domain.dart';

abstract interface class IAuthRepository {
  Future<SendOtpResult> sendOtp({required String identifier});

  Future<AuthorizedResult> verifyOtp({
    required String identifier,
    required String code,
  });

  Future<AuthToken> refreshToken({required String refreshToken});

  Future<void> saveToken(AuthToken token);

  Future<void> deleteToken();

  Future<AuthToken?> getSavedToken();
}

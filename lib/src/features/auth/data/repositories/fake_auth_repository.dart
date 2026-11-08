import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@Injectable(as: IAuthRepository, env: [AuthConfig.fake])
class FakeAuthRepository implements IAuthRepository {
  final FakeUserStore _users;
  final IAuthTokenStore _tokens;
  const FakeAuthRepository(this._users, this._tokens);

  static final _random = Random.secure();
  static const _tokenBytes = 24;

  @override
  Future<SendOtpResult> sendOtp({required String identifier}) async {
    await Future.delayed(AuthConfig.fakeStepDelay);
    return const SendOtpResult(success: true, message: 'OTP sent');
  }

  @override
  Future<AuthorizedResult> verifyOtp({
    required String identifier,
    required String code,
  }) async {
    await Future.delayed(AuthConfig.fakeStepDelay);
    if (code != AuthConfig.fakeOtpCode) {
      throw const BadRequestError('Invalid OTP');
    }
    final user = await _users.findOrCreate(identifier);
    return AuthorizedResult(
      isNewUser: user.name.trim().isEmpty,
      userInfo: user,
      token: _issueToken(),
    );
  }

  @override
  Future<AuthToken> refreshToken({required String refreshToken}) async {
    await Future.delayed(AuthConfig.fakeStepDelay);
    return _issueToken();
  }

  @override
  Future<AuthToken?> getSavedToken() async => _tokens.current;

  @override
  Future<void> saveToken(AuthToken token) => _tokens.save(token);

  @override
  Future<void> deleteToken() => _tokens.clear();

  static AuthToken _issueToken() =>
      AuthToken(accessToken: _randomHex(), refreshToken: _randomHex());

  static String _randomHex() => List.generate(
    _tokenBytes,
    (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
}

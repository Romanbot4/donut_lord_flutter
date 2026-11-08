import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

@Injectable(as: IAuthRepository, env: [AuthConfig.remote])
class RemoteAuthRepository implements IAuthRepository {
  final AuthApiClient _client;
  final IAuthTokenStore _tokens;
  const RemoteAuthRepository(this._client, this._tokens);

  @override
  Future<SendOtpResult> sendOtp({required String identifier}) {
    return withMinimumDuration(
      _client.sendOtp(SendOtpRequest(identifier: identifier)),
      NetworkConfig.authStepMinimumDuration,
    );
  }

  @override
  Future<AuthorizedResult> verifyOtp({
    required String identifier,
    required String code,
  }) {
    return withMinimumDuration(
      _client.verifyOtp(VerifyOtpRequest(identifier: identifier, code: code)),
      NetworkConfig.authStepMinimumDuration,
    );
  }

  @override
  Future<AuthToken> refreshToken({required String refreshToken}) {
    return _client.refreshToken(
      RefreshTokenRequest(refreshToken: refreshToken),
    );
  }

  @override
  Future<AuthToken?> getSavedToken() async => _tokens.current;

  @override
  Future<void> saveToken(AuthToken token) => _tokens.save(token);

  @override
  Future<void> deleteToken() => _tokens.clear();
}

import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

const _token = AuthToken(accessToken: 'access', refreshToken: 'refresh');
const _refreshedToken = AuthToken(accessToken: 'new', refreshToken: 'new-r');
const _user = UserEntity(id: '1', name: 'Ye Min', identifier: '+959254135592');

class _FakeAuthRepository implements IAuthRepository {
  AuthToken? savedToken;

  @override
  Future<AuthorizedResult> verifyOtp({
    required String identifier,
    required String code,
  }) async =>
      const AuthorizedResult(isNewUser: true, userInfo: _user, token: _token);

  @override
  Future<AuthToken> refreshToken({required String refreshToken}) async =>
      _refreshedToken;

  @override
  Future<AuthToken?> getSavedToken() async => savedToken;

  @override
  Future<void> saveToken(AuthToken token) async => savedToken = token;

  @override
  Future<void> deleteToken() async => savedToken = null;

  @override
  Future<SendOtpResult> sendOtp({required String identifier}) async =>
      const SendOtpResult(success: true, message: '');
}

class _FakeUserRepository implements IUserRepository {
  UserEntity? savedUser;

  @override
  Future<UserEntity?> getSavedUserInfo() async => savedUser;

  @override
  Future<void> saveUserInfo(UserEntity user) async => savedUser = user;

  @override
  Future<void> deleteUserInfo() async => savedUser = null;

  @override
  Future<UserEntity> getMe() async => _user;

  @override
  Future<UserEntity> updateUserInfo({
    required String id,
    String? name,
    String? password,
    String? profilePicturePath,
    DateTime? dateOfBirth,
  }) async => _user;
}

void main() {
  late _FakeAuthRepository auth;
  late _FakeUserRepository users;

  setUp(() {
    auth = _FakeAuthRepository();
    users = _FakeUserRepository();
  });

  test('verifying an OTP saves the token and the user', () async {
    final result = await VerifyOtpUseCase(auth, users)(
      const VerifyOtpParam(identifier: '+959254135592', code: '123456'),
    );

    expect(result.isSuccess, isTrue);
    expect(auth.savedToken, _token);
    expect(users.savedUser, _user);
  });

  test('refreshing without a saved token fails as auth required', () async {
    final result = await RefreshTokenUseCase(auth)(null);

    expect(result.failure, isA<AuthRequiredFailure>());
  });

  test('refreshing saves the new token', () async {
    auth.savedToken = _token;

    final result = await RefreshTokenUseCase(auth)(null);

    expect(result.data, _refreshedToken);
    expect(auth.savedToken, _refreshedToken);
  });

  test('logging out clears the token and the user', () async {
    auth.savedToken = _token;
    users.savedUser = _user;

    await LogOutUseCase(auth, users)(null);

    expect(auth.savedToken, isNull);
    expect(users.savedUser, isNull);
  });
}

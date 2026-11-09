import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

const validOtp = '123456';
const wrongOtp = '111111';

const registeringUser = UserEntity(
  id: '1',
  name: '',
  identifier: '+959254135592',
);

class FakeAuthRepository implements IAuthRepository {
  final Duration sendDelay;
  AuthToken? savedToken;

  FakeAuthRepository({this.sendDelay = Duration.zero});

  @override
  Future<SendOtpResult> sendOtp({required String identifier}) async {
    await Future<void>.delayed(sendDelay);
    return const SendOtpResult(success: true, message: 'sent');
  }

  @override
  Future<AuthorizedResult> verifyOtp({
    required String identifier,
    required String code,
  }) async {
    if (code != validOtp) throw const BadRequestError('Invalid OTP');
    return const AuthorizedResult(
      isNewUser: true,
      userInfo: registeringUser,
      token: AuthToken(accessToken: 'access', refreshToken: 'refresh'),
    );
  }

  @override
  Future<AuthToken> refreshToken({required String refreshToken}) async =>
      throw const AuthRequiredError();

  @override
  Future<void> saveToken(AuthToken token) async => savedToken = token;

  @override
  Future<void> deleteToken() async => savedToken = null;

  @override
  Future<AuthToken?> getSavedToken() async => savedToken;
}

class MemoryUserRepository implements IUserRepository {
  UserEntity? savedUser;
  UserEntity? lastUpdate;

  @override
  Future<UserEntity> getMe() async => savedUser ?? registeringUser;

  @override
  Future<UserEntity?> getSavedUserInfo() async => savedUser;

  @override
  Future<void> saveUserInfo(UserEntity user) async => savedUser = user;

  @override
  Future<void> deleteUserInfo() async => savedUser = null;

  @override
  Future<UserEntity> updateUserInfo({
    required String id,
    String? name,
    String? password,
    String? profilePicturePath,
    DateTime? dateOfBirth,
  }) async {
    final current = savedUser ?? registeringUser;
    return lastUpdate = UserEntity(
      id: id,
      name: name ?? current.name,
      identifier: current.identifier,
      dateOfBirth: dateOfBirth ?? current.dateOfBirth,
    );
  }
}

class SilentSnackShower implements ISnackShower {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class UnusedLocalization implements ILocalization {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class QuietSessionEvents implements ISessionEvents {
  @override
  Stream<void> get onExpired => const Stream.empty();

  @override
  void expire() {}
}

SessionCubit buildSessionCubit(
  FakeAuthRepository auth,
  MemoryUserRepository users,
) => SessionCubit(
  GetSavedUserUseCase(users),
  GetMeUseCase(users),
  SaveUserInfoUseCase(users),
  LogOutUseCase(auth, users),
  SilentSnackShower(),
  UnusedLocalization(),
  QuietSessionEvents(),
);

Widget localizedApp(Widget home) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);

Widget routedApp(Widget home, {List<String> otherPaths = const []}) =>
    MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        routes: [
          GoRoute(path: '/', builder: (_, _) => home),
          for (final path in otherPaths)
            GoRoute(path: path, builder: (_, _) => Text(path)),
        ],
      ),
    );

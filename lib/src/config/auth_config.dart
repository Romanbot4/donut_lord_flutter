import 'package:injectable/injectable.dart';

abstract final class AuthConfig {
  static const remote = 'remote';
  static const fake = 'fake';

  static const backend = String.fromEnvironment(
    'AUTH_BACKEND',
    defaultValue: fake,
  );

  static const fakeStepDelay = Duration(seconds: 1);

  static const fakeOtpCode = '000000';
}

const remoteAuth = Environment(AuthConfig.remote);

const fakeAuth = Environment(AuthConfig.fake);

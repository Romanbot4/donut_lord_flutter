import 'package:jdonuts/src/config/config.dart';

abstract final class AuthApi {
  static String get baseUrl => '${FlavorizedNetworkConfig.baseUrl}/user';
}

abstract final class AuthExtra {
  static const skipAuth = 'auth.skip';

  static const retried = 'auth.retried';
}

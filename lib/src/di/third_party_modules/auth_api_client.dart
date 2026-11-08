import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';

@module
abstract class AuthApiClientProvider {
  @Injectable(env: [AuthConfig.remote])
  AuthApiClient provide(Dio dio) => AuthApiClient(dio, baseUrl: AuthApi.baseUrl);
}

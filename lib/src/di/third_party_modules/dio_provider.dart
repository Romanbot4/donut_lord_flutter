import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

@module
abstract class DioProvider {
  @lazySingleton
  Dio provide(IAuthTokenStore tokens, ISessionEvents session) {
    final dio = _createDio();
    final refreshClient = AuthApiClient(_createDio(), baseUrl: AuthApi.baseUrl);
    dio.interceptors.insert(
      0,
      AuthInterceptor(dio, refreshClient, tokens, session),
    );
    return dio;
  }

  static Dio _createDio() {
    return Dio(
        BaseOptions(
          headers: NetworkConfig.defaultHeaders,
          receiveTimeout: NetworkConfig.receiveTimeout,
          connectTimeout: NetworkConfig.connectTimeout,
          sendTimeout: NetworkConfig.sendTimeout,
        ),
      )
      ..interceptors.addAll([
        if (kDebugMode)
          TalkerDioLogger(
            settings: const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseData: true,
              printRequestData: true,
            ),
          ),
      ]);
  }
}

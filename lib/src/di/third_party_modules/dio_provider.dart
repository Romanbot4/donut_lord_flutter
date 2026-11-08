import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

@module
abstract class DioProvider {
  @lazySingleton
  Dio provide() {
    final dio =
        Dio(
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

    return dio;
  }
}

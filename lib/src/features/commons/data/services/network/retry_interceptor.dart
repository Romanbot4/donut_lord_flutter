import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jdonuts/src/config/config.dart';

class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int maxRetries;
  final Duration delay;

  RetryInterceptor(
    this._dio, {
    this.maxRetries = NetworkConfig.maxRetries,
    this.delay = NetworkConfig.retryDelay,
  });

  static const _attemptKey = 'retry.attempt';

  static const _retryableTypes = {
    DioExceptionType.connectionError,
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.sendTimeout,
  };

  static bool _isConnectionProblem(DioException err) =>
      _retryableTypes.contains(err.type) || err.error is SocketException;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra[_attemptKey] as int?) ?? 0;
    final canRetry =
        options.method == 'GET' &&
        _isConnectionProblem(err) &&
        attempt < maxRetries;
    if (!canRetry) return handler.next(err);

    await Future<void>.delayed(delay * (attempt + 1));
    options.extra[_attemptKey] = attempt + 1;
    try {
      handler.resolve(await _dio.fetch(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}

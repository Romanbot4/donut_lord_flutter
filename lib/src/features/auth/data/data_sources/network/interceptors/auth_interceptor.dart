import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

/// Reusable auth intercepter
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final AuthApiClient _refreshClient;
  final IAuthTokenStore _tokens;
  final ISessionEvents _session;

  AuthInterceptor(this._dio, this._refreshClient, this._tokens, this._session);

  static const _sessionEndedStatuses = {
    HttpStatus.unauthorized,
    HttpStatus.forbidden,
    HttpStatus.networkAuthenticationRequired,
  };

  Future<bool>? _refreshing;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = _tokens.current?.accessToken;
    if (accessToken != null && options.extra[AuthExtra.skipAuth] != true) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final canRefresh =
        err.response?.statusCode == HttpStatus.unauthorized &&
        options.extra[AuthExtra.skipAuth] != true &&
        options.extra[AuthExtra.retried] != true;
    if (!canRefresh) return handler.next(err);

    final refreshed = await (_refreshing ??= _refresh().whenComplete(
      () => _refreshing = null,
    ));
    if (!refreshed) return handler.next(err);

    options.extra[AuthExtra.retried] = true;
    try {
      handler.resolve(await _dio.fetch(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<bool> _refresh() async {
    final refreshToken = _tokens.current?.refreshToken;
    if (refreshToken == null) return false;

    try {
      final token = await _refreshClient.refreshToken(
        RefreshTokenRequest(refreshToken: refreshToken),
      );
      await _tokens.save(token);
      return true;
    } on DioException catch (e) {
      if (_sessionEndedStatuses.contains(e.response?.statusCode)) {
        if (await _tokens.clear()) _session.expire();
      }
      return false;
    }
  }
}

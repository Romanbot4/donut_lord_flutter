import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

const _oldToken = AuthToken(accessToken: 'old', refreshToken: 'old-r');
const _baseUrl = 'https://api.test';

typedef _Reply = Future<ResponseBody> Function(RequestOptions options);

class _StubAdapter implements HttpClientAdapter {
  final _Reply reply;
  int calls = 0;

  _StubAdapter(this.reply);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    calls++;
    return reply(options);
  }

  @override
  void close({bool force = false}) {}
}

class _MemoryTokenStore implements IAuthTokenStore {
  @override
  AuthToken? current = _oldToken;

  @override
  Future<void> save(AuthToken token) async => current = token;

  @override
  Future<bool> clear() async {
    final hadToken = current != null;
    current = null;
    return hadToken;
  }
}

class _CountingSessionEvents implements ISessionEvents {
  int expiredCount = 0;

  @override
  Stream<void> get onExpired => const Stream.empty();

  @override
  void expire() => expiredCount++;
}

ResponseBody _json(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Future<ResponseBody> _okOnlyWithNewToken(RequestOptions options) async {
  final authorized =
      options.headers[HttpHeaders.authorizationHeader] == 'Bearer new';
  return authorized ? _json(200, {}) : _json(401, {});
}

Future<ResponseBody> _refreshSucceeds(RequestOptions options) async {
  await Future<void>.delayed(const Duration(milliseconds: 20));
  return _json(200, {'accessToken': 'new', 'refreshToken': 'new-r'});
}

void main() {
  late _MemoryTokenStore tokens;
  late _CountingSessionEvents session;

  setUp(() {
    tokens = _MemoryTokenStore();
    session = _CountingSessionEvents();
  });

  (Dio, _StubAdapter) buildDio({required _Reply api, required _Reply refresh}) {
    final refreshAdapter = _StubAdapter(refresh);
    final refreshDio = Dio()..httpClientAdapter = refreshAdapter;
    final dio = Dio(BaseOptions(baseUrl: _baseUrl))
      ..httpClientAdapter = _StubAdapter(api);
    dio.interceptors.add(
      AuthInterceptor(
        dio,
        AuthApiClient(refreshDio, baseUrl: _baseUrl),
        tokens,
        session,
      ),
    );
    return (dio, refreshAdapter);
  }

  test('concurrent 401s refresh once and replay with the new token', () async {
    final (dio, refresh) = buildDio(
      api: _okOnlyWithNewToken,
      refresh: _refreshSucceeds,
    );

    final responses = await Future.wait([dio.get('/a'), dio.get('/b')]);

    expect(responses.map((r) => r.statusCode), [200, 200]);
    expect(refresh.calls, 1);
    expect(tokens.current?.accessToken, 'new');
  });

  test(
    'a refused refresh clears the tokens and expires the session once',
    () async {
      final (dio, _) = buildDio(
        api: _okOnlyWithNewToken,
        refresh: (_) async =>
            _json(HttpStatus.networkAuthenticationRequired, {}),
      );

      await expectLater(
        Future.wait([dio.get('/a'), dio.get('/b')]),
        throwsA(isA<DioException>()),
      );

      expect(tokens.current, isNull);
      expect(session.expiredCount, 1);
    },
  );

  test('a refresh that fails offline keeps the user signed in', () async {
    final (dio, _) = buildDio(
      api: _okOnlyWithNewToken,
      refresh: (_) async => throw const SocketException('offline'),
    );

    await expectLater(dio.get('/a'), throwsA(isA<DioException>()));

    expect(tokens.current, _oldToken);
    expect(session.expiredCount, 0);
  });

  test(
    'a replayed request that gets 401 again is not refreshed again',
    () async {
      final (dio, refresh) = buildDio(
        api: (_) async => _json(401, {}),
        refresh: _refreshSucceeds,
      );

      await expectLater(dio.get('/a'), throwsA(isA<DioException>()));

      expect(refresh.calls, 1);
    },
  );
}

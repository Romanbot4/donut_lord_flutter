import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

class _FlakyAdapter implements HttpClientAdapter {
  final int failuresBeforeSuccess;
  final int failureStatus;
  int calls = 0;

  _FlakyAdapter({this.failuresBeforeSuccess = 0, this.failureStatus = 0});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    if (failureStatus != 0) return ResponseBody.fromString('', failureStatus);
    if (calls <= failuresBeforeSuccess) {
      throw const SocketException('offline');
    }
    return ResponseBody.fromString('', 200);
  }

  @override
  void close({bool force = false}) {}
}

(Dio, _FlakyAdapter) _dioWith(_FlakyAdapter adapter) {
  final dio = Dio()..httpClientAdapter = adapter;
  dio.interceptors.add(RetryInterceptor(dio, delay: Duration.zero));
  return (dio, adapter);
}

void main() {
  test('retries a GET after connection errors until it succeeds', () async {
    final (dio, adapter) = _dioWith(_FlakyAdapter(failuresBeforeSuccess: 2));

    final response = await dio.get<void>('https://api.test/home');

    expect(response.statusCode, 200);
    expect(adapter.calls, 3);
  });

  test('gives up after the maximum number of retries', () async {
    final (dio, adapter) = _dioWith(_FlakyAdapter(failuresBeforeSuccess: 10));

    await expectLater(
      dio.get<void>('https://api.test/home'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.calls, 1 + RetryInterceptor(dio).maxRetries);
  });

  test('does not retry requests that change data', () async {
    final (dio, adapter) = _dioWith(_FlakyAdapter(failuresBeforeSuccess: 1));

    await expectLater(
      dio.post<void>('https://api.test/auth/verify-otp'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.calls, 1);
  });

  test('does not retry server responses', () async {
    final (dio, adapter) = _dioWith(_FlakyAdapter(failureStatus: 404));

    await expectLater(
      dio.get<void>('https://api.test/products/x'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.calls, 1);
  });
}

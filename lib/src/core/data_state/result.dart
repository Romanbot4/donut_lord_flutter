import 'package:jdonuts/src/core/core.dart';

class Result<TData> {
  final bool _isSuccess;
  final Failure? _failure;
  final TData? _data;

  Result._({required this._isSuccess, this._failure, this._data});

  bool get isFailure => !_isSuccess;

  bool get isSuccess => _isSuccess;

  Failure get failure {
    if (_isSuccess) {
      throw InvalidOperationError(
        'The failure cannot be accessed. The result is marked as success.',
      );
    }
    return _failure!;
  }

  TData get data {
    if (!_isSuccess) {
      throw InvalidOperationError(
        'The data cannot be accessed. The result is marked as failure.',
      );
    }
    return _data as TData;
  }

  factory Result.success([TData? data]) {
    return Result._(isSuccess: true, data: data);
  }

  factory Result.fail(Failure failure) {
    return Result._(isSuccess: false, failure: failure);
  }

  TReturn map<TReturn>({
    required TReturn Function(TData data) onSuccess,
    required TReturn Function(Failure failure) onFailure,
  }) {
    if (_isSuccess) return onSuccess(data);
    return onFailure(_failure ?? Failure.unkown());
  }

  void when({
    required void Function(TData data) onSuccess,
    required void Function(Failure failure) onFailure,
  }) {
    if (_isSuccess) return onSuccess(data);
    return onFailure(_failure ?? Failure.unkown());
  }
}

extension UseCaseExtension<TData> on Future<Result<TData>> {
  Future<TReturn> thenMap<TReturn>({
    required TReturn Function(TData data) onSuccess,
    required TReturn Function(Failure failure) onFailure,
  }) async => (await this).map(onSuccess: onSuccess, onFailure: onFailure);

  Future<void> thenWhen({
    required void Function(TData data) onSuccess,
    required void Function(Failure failure) onFailure,
  }) async => (await this).when(onSuccess: onSuccess, onFailure: onFailure);
}

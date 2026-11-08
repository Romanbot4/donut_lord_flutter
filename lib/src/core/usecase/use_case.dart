import 'package:flutter/foundation.dart';
import 'package:jdonuts/src/core/core.dart';

abstract class UseCase<TData, TParam> {
  const UseCase();
  Future<Result<TData>> call(TParam param) async {
    try {
      return Result.success(await handle(param));
    } on CoreError catch (e) {
      return Result.fail(e.toFailure());
    } catch (e) {
      final coreError = IExceptionMapperService.instance.map(e);
      if (coreError != null) return Result.fail(coreError.toFailure());
      if (kDebugMode) {
        rethrow;
      } else {
        return Result.fail(UnknownNetworkFailure(message: "Unknown error"));
      }
    }
  }

  Future<TData> handle(TParam param);
}

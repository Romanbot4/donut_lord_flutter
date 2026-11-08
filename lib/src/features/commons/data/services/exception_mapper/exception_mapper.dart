import 'package:dio/dio.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

/// Registered (and assigned to [IExceptionMapperService.instance]) by
/// `di/third_party_modules/exception_mapper.dart`, so it has no injectable
/// annotation of its own.
class ExceptionMapperService implements IExceptionMapperService {
  @override
  CoreError? map(Object e) {
    if (e is DioException) {
      return e.toNetworkError();
    }
    return null;
  }
}

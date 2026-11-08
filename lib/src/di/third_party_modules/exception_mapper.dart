import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

@module
abstract class ExceptionMapperServiceProvider {
  /// Eager, so [IExceptionMapperService.instance] is set as soon as
  /// dependencies are configured.
  @singleton
  IExceptionMapperService provide() =>
      IExceptionMapperService.instance = ExceptionMapperService();
}

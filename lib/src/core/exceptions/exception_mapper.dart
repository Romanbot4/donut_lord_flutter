import 'package:jdonuts/src/core/core.dart';

abstract interface class IExceptionMapperService {
  static late IExceptionMapperService instance;

  CoreError? map(Object e);
}

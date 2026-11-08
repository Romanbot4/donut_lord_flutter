import 'package:jdonuts/src/core/core.dart';

abstract class CoreError implements Exception {
  final String message;
  const CoreError(this.message);

  Failure toFailure();
}

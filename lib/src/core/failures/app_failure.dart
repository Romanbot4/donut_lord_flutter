import 'package:jdonuts/src/core/core.dart';

class AppFailure extends Failure {
  const AppFailure({required super.code, required super.message});
}

class NoContentFailure extends AppFailure {
  const NoContentFailure({required super.message})
    : super(code: FailureCodes.noContent);
}

class InvalidOperationFailure extends AppFailure {
  const InvalidOperationFailure({required super.message})
    : super(code: FailureCodes.invalidOperationError);
}

class InvalidArgumentFailure extends AppFailure {
  const InvalidArgumentFailure({required super.message})
    : super(code: FailureCodes.invalidArgumentError);
}

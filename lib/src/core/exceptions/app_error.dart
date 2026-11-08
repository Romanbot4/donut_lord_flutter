import 'package:jdonuts/src/core/core.dart';

class InvalidOperationError extends CoreError {
  const InvalidOperationError([super.message = "Invalid operation."]);

  @override
  Failure toFailure() {
    return InvalidOperationFailure(message: message);
  }
}

class InvalidArgumentError extends CoreError {
  const InvalidArgumentError([super.message = "Invalid argument."]);

  @override
  Failure toFailure() {
    return InvalidArgumentFailure(message: message);
  }
}

class NoContentError extends CoreError {
  const NoContentError([super.message = "No content."]);

  @override
  Failure toFailure() {
    return NoContentFailure(message: message);
  }
}

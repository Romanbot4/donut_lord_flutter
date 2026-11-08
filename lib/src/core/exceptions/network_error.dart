import 'package:jdonuts/src/core/core.dart';

abstract class NetworkError extends CoreError {
  const NetworkError([super.message = "Network error"]);
}

class ConnectionError extends NetworkError {
  const ConnectionError([super.message = "No internet connection"]);

  @override
  Failure toFailure() {
    return ConnectionFailure(message: message);
  }
}

class MaintenanceError extends NetworkError {
  const MaintenanceError([super.message = "No internet connection"]);

  @override
  Failure toFailure() {
    return MaintenanceFailure(message: message);
  }
}

class TimeoutError extends NetworkError {
  const TimeoutError([super.message = "Request timed out"]);

  @override
  Failure toFailure() {
    return TimeoutFailure(message: message);
  }
}

class TooManyRequestError extends NetworkError {
  const TooManyRequestError([super.message = "Too many requests"]);

  @override
  Failure toFailure() {
    return TooManyRequestFailure(message: message);
  }
}

class NotFoundError extends NetworkError {
  const NotFoundError([super.message = "Resource not found"]);

  @override
  Failure toFailure() {
    return NotFoundFailure(message: message);
  }
}

class BadRequestError extends NetworkError {
  const BadRequestError([super.message = "Bad request"]);

  @override
  Failure toFailure() {
    return BadRequestFailure(message: message);
  }
}

class PermissionRequiredError extends NetworkError {
  const PermissionRequiredError([super.message = "Permission required"]);

  @override
  Failure toFailure() {
    return PermissionRequiredFailure(message: message);
  }
}

class AuthRequiredError extends NetworkError {
  const AuthRequiredError([super.message = "Authentication required"]);

  @override
  Failure toFailure() {
    return AuthRequiredFailure(message: message);
  }
}

class AuthExpiredError extends NetworkError {
  const AuthExpiredError([super.message = "Authentication expired"]);

  @override
  Failure toFailure() {
    return AuthExpiredFailure(message: message);
  }
}

class UnknownNetworkError extends NetworkError {
  const UnknownNetworkError([super.message = "Unknown network error"]);

  @override
  Failure toFailure() {
    return UnknownNetworkFailure(message: message);
  }
}

import 'package:jdonuts/src/core/failures/failure_codes.dart';

import 'failure.dart';

abstract class NetworkFailure extends Failure {
  const NetworkFailure({required super.code, required super.message});
}

class ConnectionFailure extends NetworkFailure {
  const ConnectionFailure({required super.message})
    : super(code: FailureCodes.noContent);
}

class MaintenanceFailure extends NetworkFailure {
  const MaintenanceFailure({required super.message})
    : super(code: FailureCodes.maintenance);
}

class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure({required super.message})
    : super(code: FailureCodes.timeoutError);
}

class TooManyRequestFailure extends NetworkFailure {
  const TooManyRequestFailure({required super.message})
    : super(code: FailureCodes.tooManyRequest);
}

class NotFoundFailure extends NetworkFailure {
  const NotFoundFailure({required super.message})
    : super(code: FailureCodes.notFound);
}

class BadRequestFailure extends NetworkFailure {
  const BadRequestFailure({required super.message})
    : super(code: FailureCodes.badRequest);
}

class PermissionRequiredFailure extends NetworkFailure {
  const PermissionRequiredFailure({required super.message})
    : super(code: FailureCodes.perissionRequired);
}

class AuthRequiredFailure extends NetworkFailure {
  const AuthRequiredFailure({required super.message})
    : super(code: FailureCodes.authRequired);
}

class AuthExpiredFailure extends NetworkFailure {
  const AuthExpiredFailure({required super.message})
    : super(code: FailureCodes.authExpired);
}

class UnknownNetworkFailure extends NetworkFailure {
  const UnknownNetworkFailure({required super.message})
    : super(code: FailureCodes.internalServerError);
}

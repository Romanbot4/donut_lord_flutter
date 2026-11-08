import 'package:dio/dio.dart';
import 'package:jdonuts/src/core/core.dart';

extension DioExceptionExtension on DioException {
  CoreError toNetworkError() {
    return switch (type) {
      DioExceptionType.badCertificate => UnknownNetworkError(
        message ?? 'Bad Certificate',
      ),
      DioExceptionType.cancel => const UnknownNetworkError('Cancel Request'),
      DioExceptionType.connectionError => const ConnectionError(
        'Connection Error',
      ),
      DioExceptionType.receiveTimeout => const TimeoutError('Receive Timeout'),
      DioExceptionType.sendTimeout => const TimeoutError('Send Time Out'),
      _ => switch (response?.statusCode) {
        400 => const BadRequestError('Bad Request'),
        429 => const TooManyRequestError('Too many requests'),
        401 => const AuthExpiredError('UnAuthorized'),
        403 => const PermissionRequiredError('Permission Denied'),
        500 || 501 => const UnknownNetworkError('Server Error'),
        503 => const MaintenanceError('Server Maintenance'),
        511 => const AuthRequiredError('Authentication Required'),
        _ => const UnknownNetworkError('An error occurred'),
      },
    };
  }
}

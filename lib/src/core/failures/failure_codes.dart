abstract class FailureCodes {
  static const int connectionError = 0;
  static const int invalidOperationError = 0;
  static const int invalidArgumentError = 0;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int authExpired = 401;
  static const int perissionRequired = 403;
  static const int notFound = 404;
  static const int unprocessable = 422;
  static const int tooManyRequest = 429;
  static const int internalServerError = 500;
  static const int notImplementedServerError = 500;
  static const int maintenance = 503;
  static const int timeoutError = 504;
  static const int authRequired = 511;
}

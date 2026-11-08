import 'failure_codes.dart';

class Failure {
  final int code;
  final String message;

  const Failure({required this.code, required this.message});

  factory Failure.unkown() => Failure(
    code: FailureCodes.notImplementedServerError,
    message: "Unkown error",
  );
}

/// Domain rules reusable otp regex base validation methods.
abstract final class OtpValidator {
  static const length = 6;

  static final _code = RegExp('^\\d{$length}\$');

  static bool isComplete(String code) => _code.hasMatch(code);
}

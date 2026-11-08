class SendOtpResult {
  final bool success;
  final String message;
  final String? code;

  const SendOtpResult({required this.success, required this.message, this.code});
}

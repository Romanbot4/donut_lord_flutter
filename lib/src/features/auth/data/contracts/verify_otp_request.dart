import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_request.g.dart';
part 'verify_otp_request.freezed.dart';

@freezed
sealed class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String identifier,
    required String code,
  }) = _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

part 'send_otp_response.g.dart';
part 'send_otp_response.freezed.dart';

@freezed
sealed class SendOtpResponse extends SendOtpResult with _$SendOtpResponse {
  const SendOtpResponse._() : super(success: false, message: "");
  static const empty = SendOtpResponse(success: false, message: "");

  const factory SendOtpResponse({
    required bool success,
    required String message,
    String? code,
  }) = _SendOtpResponse;

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseFromJson(json);
}

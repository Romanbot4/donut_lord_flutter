import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_otp_request.g.dart';
part 'send_otp_request.freezed.dart';

@freezed
sealed class SendOtpRequest with _$SendOtpRequest {
  const factory SendOtpRequest({required String identifier}) = _SendOtpRequest;

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestFromJson(json);
}

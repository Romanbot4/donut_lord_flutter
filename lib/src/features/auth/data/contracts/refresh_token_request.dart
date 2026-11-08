import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_request.g.dart';
part 'refresh_token_request.freezed.dart';

@freezed
sealed class RefreshTokenRequest with _$RefreshTokenRequest {
  const factory RefreshTokenRequest({required String refreshToken}) =
      _RefreshTokenRequest;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);
}

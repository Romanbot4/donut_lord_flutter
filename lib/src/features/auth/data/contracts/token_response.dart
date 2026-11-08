import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

part 'token_response.g.dart';
part 'token_response.freezed.dart';

@freezed
sealed class TokenResponse extends AuthToken with _$TokenResponse {
  const TokenResponse._() : super(accessToken: "", refreshToken: "");

  static const empty = TokenResponse(accessToken: "", refreshToken: "");

  const factory TokenResponse({
    required String accessToken,
    required String refreshToken,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  static TokenResponse fromEntity(AuthToken result) {
    return TokenResponse(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    );
  }
}

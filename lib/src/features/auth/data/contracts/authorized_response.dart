import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

part 'authorized_response.g.dart';
part 'authorized_response.freezed.dart';

@freezed
sealed class AuthorizedResponse extends AuthorizedResult
    with _$AuthorizedResponse {
  const AuthorizedResponse._()
    : super(
        isNewUser: false,
        userInfo: UserModel.empty,
        token: TokenResponse.empty,
      );

  static const empty = AuthorizedResponse(
    isNewUser: false,
    userInfo: UserModel.empty,
    token: TokenResponse.empty,
  );

  const factory AuthorizedResponse({
    required bool isNewUser,
    required UserModel userInfo,
    required TokenResponse token,
  }) = _AuthorizedResponse;

  factory AuthorizedResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedResponseFromJson(json);
}

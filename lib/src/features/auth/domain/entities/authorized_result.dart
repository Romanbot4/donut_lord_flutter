import 'package:jdonuts/src/features/auth/domain/domain.dart';

class AuthorizedResult {
  final bool isNewUser;
  final UserEntity userInfo;
  final AuthToken token;

  const AuthorizedResult({
    required this.isNewUser,
    required this.userInfo,
    required this.token,
  });
}

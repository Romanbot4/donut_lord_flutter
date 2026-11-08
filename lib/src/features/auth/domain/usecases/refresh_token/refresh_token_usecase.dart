import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

@injectable
class RefreshTokenUseCase extends UseCase<AuthToken, void> {
  final IAuthRepository _repository;
  const RefreshTokenUseCase(this._repository);

  @override
  Future<AuthToken> handle(void param) async {
    final savedToken = await _repository.getSavedToken();
    final refreshToken = savedToken?.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw const AuthRequiredError();
    }

    final token = await _repository.refreshToken(refreshToken: refreshToken);
    await _repository.saveToken(token);
    return token;
  }
}

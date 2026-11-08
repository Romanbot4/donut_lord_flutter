import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

import 'session_cubit.dart';

@module
abstract class SessionCubitProvider {
  @preResolve
  @singleton
  Future<SessionCubit> provide(
    GetSavedUserUseCase getSavedUser,
    GetMeUseCase getMe,
    SaveUserInfoUseCase saveUserInfo,
    LogOutUseCase logOut,
    ISnackShower snackShower,
    ILocalization localization,
    ISessionEvents sessionEvents,
  ) async {
    final instance = SessionCubit(
      getSavedUser,
      getMe,
      saveUserInfo,
      logOut,
      snackShower,
      localization,
      sessionEvents,
    );
    await instance.restore();
    return instance;
  }
}

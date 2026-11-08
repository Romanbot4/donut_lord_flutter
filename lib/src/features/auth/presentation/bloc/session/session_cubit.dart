import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

part 'session_state.dart';
part 'session_cubit.freezed.dart';

class SessionCubit extends Cubit<SessionState> {
  final GetSavedUserUseCase _getSavedUser;
  final GetMeUseCase _getMe;
  final SaveUserInfoUseCase _saveUserInfo;
  final LogOutUseCase _logOut;
  final ISnackShower _snackShower;
  final ILocalization _localization;
  late final StreamSubscription<void> _expirySubscription;

  SessionCubit(
    this._getSavedUser,
    this._getMe,
    this._saveUserInfo,
    this._logOut,
    this._snackShower,
    this._localization,
    ISessionEvents sessionEvents,
  ) : super(const SessionState.unauthenticated()) {
    _expirySubscription = sessionEvents.onExpired.listen(
      (_) => _onSessionExpired(),
    );
  }

  String? get userId => switch (state) {
    SessionAuthenticated(:final user) => user.id,
    _ => null,
  };

  Future<void> restore() async {
    final saved = await _getSavedUser(null);
    final user = saved.isSuccess ? saved.data : null;
    if (user == null) return;

    emit(SessionState.authenticated(user: user));
    unawaited(_refreshProfile());
  }

  Future<void> signIn(UserEntity user, {bool isNewUser = false}) async {
    await _saveUserInfo(SaveUserInfoParam(user));
    emit(SessionState.authenticated(user: user, isNewUser: isNewUser));
  }

  Future<void> logOut() async {
    await _signOut();
    _snackShower.success(message: _localization.localizations.lblLogoutSuccess);
  }

  Future<void> _refreshProfile() async {
    final result = await _getMe(null);
    final current = state;
    if (result.isSuccess && current is SessionAuthenticated) {
      emit(current.copyWith(user: result.data));
    }
  }

  Future<void> _onSessionExpired() async {
    if (state is! SessionAuthenticated) return;
    await _signOut();
    _snackShower.info(message: _localization.localizations.lblSessionExpired);
  }

  Future<void> _signOut() async {
    emit(const SessionState.unauthenticated());
    await _logOut(null);
  }

  @override
  Future<void> close() async {
    await _expirySubscription.cancel();
    return super.close();
  }
}

part of 'session_cubit.dart';

@freezed
sealed class SessionState with _$SessionState {
  const factory SessionState.unauthenticated() = SessionUnauthenticated;
  const factory SessionState.authenticated({
    required UserEntity user,
    @Default(false) bool isNewUser,
  }) = SessionAuthenticated;
}

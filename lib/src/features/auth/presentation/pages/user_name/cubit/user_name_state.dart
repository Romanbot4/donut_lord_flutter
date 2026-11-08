part of 'user_name_cubit.dart';

@freezed
sealed class UserNameState with _$UserNameState {
  const factory UserNameState.initial() = UserNameInitial;
  const factory UserNameState.submitting() = UserNameSubmitting;
  const factory UserNameState.saved() = UserNameSaved;
  const factory UserNameState.failed(Failure failure) = UserNameFailed;
}

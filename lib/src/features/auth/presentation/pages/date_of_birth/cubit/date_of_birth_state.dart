part of 'date_of_birth_cubit.dart';

@freezed
abstract class DateOfBirthState with _$DateOfBirthState {
  const DateOfBirthState._();

  const factory DateOfBirthState({
    int? month,
    int? day,
    int? year,
    @Default(DateOfBirthError.incomplete) DateOfBirthError? error,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSaved,
    Failure? failure,
  }) = _DateOfBirthState;

  bool get isValid => error == null;

  DateOfBirthError? get visibleError =>
      error == DateOfBirthError.incomplete ? null : error;
}

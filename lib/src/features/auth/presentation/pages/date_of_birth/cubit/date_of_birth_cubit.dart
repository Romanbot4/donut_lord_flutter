import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';

part 'date_of_birth_state.dart';
part 'date_of_birth_cubit.freezed.dart';

@injectable
class DateOfBirthCubit extends Cubit<DateOfBirthState> {
  final UpdateUserInfoUseCase _updateUserInfo;
  final SessionCubit _session;

  DateOfBirthCubit(this._updateUserInfo, this._session)
    : super(const DateOfBirthState());

  void onMonthChanged(int month) => _update(state.copyWith(month: month));

  void onDayChanged(String value) =>
      _update(state.copyWith(day: int.tryParse(value.trim())));

  void onYearChanged(String value) =>
      _update(state.copyWith(year: int.tryParse(value.trim())));

  Future<void> submit() async {
    // Disabled while invalid; a double tap in flight sends one request.
    final userId = _session.userId;
    if (!state.isValid || state.isSubmitting || userId == null) return;

    emit(state.copyWith(isSubmitting: true, failure: null));
    final result = await _updateUserInfo(
      UpdateUserInfoParam(id: userId, dateOfBirth: _selectedDate()),
    );
    if (isClosed) return;

    if (result.isSuccess) {
      await _session.signIn(result.data, isNewUser: true);
      emit(state.copyWith(isSubmitting: false, isSaved: true));
    } else {
      emit(state.copyWith(isSubmitting: false, failure: result.failure));
    }
  }

  void _update(DateOfBirthState next) {
    final error = DateOfBirthValidator.validate(
      year: next.year,
      month: next.month,
      day: next.day,
      today: DateTime.now(),
    );
    emit(next.copyWith(error: error));
  }

  DateTime _selectedDate() => DateOfBirthValidator.toDate(
    year: state.year!,
    month: state.month!,
    day: state.day!,
  )!;
}

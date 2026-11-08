import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';

part 'user_name_state.dart';
part 'user_name_cubit.freezed.dart';

@injectable
class UserNameCubit extends Cubit<UserNameState> {
  final UpdateUserInfoUseCase _updateUserInfo;
  final SessionCubit _session;

  UserNameCubit(this._updateUserInfo, this._session)
    : super(const UserNameState.initial());

  Future<void> submit({
    required String firstName,
    required String lastName,
  }) async {
    // A double tap while the request is in flight sends only one request.
    final userId = _session.userId;
    if (state is UserNameSubmitting || userId == null) return;

    emit(const UserNameState.submitting());
    final result = await _updateUserInfo(
      UpdateUserInfoParam(
        id: userId,
        name: NameValidator.fullName(firstName, lastName),
      ),
    );
    if (isClosed) return;

    if (result.isSuccess) {
      await _session.signIn(result.data, isNewUser: true);
      emit(const UserNameState.saved());
    } else {
      emit(UserNameState.failed(result.failure));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';

part 'otp_state.dart';
part 'otp_cubit.freezed.dart';

@injectable
class OtpCubit extends Cubit<OtpState> {
  final SendOtpUseCase _sendOtp;
  final VerifyOtpUseCase _verifyOtp;
  final SessionCubit _session;

  OtpCubit(this._sendOtp, this._verifyOtp, this._session)
    : super(const OtpState());

  static const resendCooldown = Duration(minutes: 5);
  static const maxWrongAttempts = 3;
  static const _tick = Duration(seconds: 1);

  late String _phoneNumber;
  Timer? _countdown;
  String? _codeEnteredWhileSending;

  Future<void> start(String phoneNumber) {
    _phoneNumber = phoneNumber;
    return _send();
  }

  Future<void> resend() async {
    if (!state.canResend) return;
    emit(state.copyWith(wrongAttempts: 0));
    await _send();
  }

  Future<void> verify(String code) async {
    if (state.status == OtpStatus.sending && OtpValidator.isComplete(code)) {
      _codeEnteredWhileSending = code;
      return;
    }
    final canVerify =
        state.status == OtpStatus.ready &&
        !state.isLocked &&
        OtpValidator.isComplete(code);
    if (!canVerify) return;

    emit(state.copyWith(status: OtpStatus.verifying, failure: null));
    final result = await _verifyOtp(
      VerifyOtpParam(identifier: _phoneNumber, code: code),
    );
    if (isClosed) return;

    if (result.isSuccess) {
      _countdown?.cancel();
      emit(state.copyWith(status: OtpStatus.verified));
      final data = result.data;
      await _session.signIn(data.userInfo, isNewUser: data.isNewUser);
      return;
    }
    _onVerifyFailed(result.failure);
  }

  Future<void> _send() async {
    emit(state.copyWith(status: OtpStatus.sending, failure: null));
    final result = await _sendOtp(SendOtpParam(identifier: _phoneNumber));
    if (isClosed) return;

    result.when(
      onSuccess: (_) {
        emit(state.copyWith(status: OtpStatus.ready));
        _startCountdown();
      },
      onFailure: (failure) =>
          emit(state.copyWith(status: OtpStatus.ready, failure: failure)),
    );
    await _verifyCodeEnteredWhileSending();
  }

  Future<void> _verifyCodeEnteredWhileSending() async {
    final code = _codeEnteredWhileSending;
    _codeEnteredWhileSending = null;
    if (code != null) await verify(code);
  }

  void _onVerifyFailed(Failure failure) {
    final isWrongCode = failure is BadRequestFailure;
    emit(
      state.copyWith(
        status: OtpStatus.ready,
        wrongAttempts: state.wrongAttempts + (isWrongCode ? 1 : 0),
        failure: isWrongCode ? null : failure,
      ),
    );
  }

  void _startCountdown() {
    _countdown?.cancel();
    emit(state.copyWith(resendIn: resendCooldown));
    _countdown = Timer.periodic(_tick, (timer) {
      final left = state.resendIn - _tick;
      emit(state.copyWith(resendIn: left));
      if (left <= Duration.zero) timer.cancel();
    });
  }

  @override
  Future<void> close() {
    _countdown?.cancel();
    return super.close();
  }
}

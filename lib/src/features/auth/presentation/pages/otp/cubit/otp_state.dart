part of 'otp_cubit.dart';

enum OtpStatus { sending, ready, verifying, verified }

@freezed
abstract class OtpState with _$OtpState {
  const OtpState._();

  const factory OtpState({
    @Default(OtpStatus.sending) OtpStatus status,
    @Default(Duration.zero) Duration resendIn,
    @Default(0) int wrongAttempts,

    Failure? failure,
  }) = _OtpState;

  bool get isLocked => wrongAttempts >= OtpCubit.maxWrongAttempts;

  bool get canResend => resendIn == Duration.zero && status == OtpStatus.ready;
}

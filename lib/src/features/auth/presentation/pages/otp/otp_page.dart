import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({super.key, required this.phoneNumber});

  static const String routePath = "/otp";
  static const String phoneParam = "phone";

  static String location(String phoneNumber) => Uri(
    path: routePath,
    queryParameters: {phoneParam: phoneNumber},
  ).toString();

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _code = '';

  @override
  void initState() {
    super.initState();
    context.read<OtpCubit>().start(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final cubit = context.read<OtpCubit>();

    return BlocListener<OtpCubit, OtpState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) =>
          Snacks.error(context, message: state.failure!.message),
      child: AuthStepLayout(
        step: 2,
        title: strings.lblEnterOtp,
        subtitle: strings.lblOtpSent(widget.phoneNumber),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.md,
          children: [
            BlocBuilder<OtpCubit, OtpState>(
              buildWhen: (previous, current) =>
                  previous.wrongAttempts != current.wrongAttempts ||
                  previous.isLocked != current.isLocked,
              builder: (context, state) => StyledOtpField(
                length: OtpValidator.length,
                enabled: !state.isLocked,
                errorCount: state.wrongAttempts,
                errorText: switch (state) {
                  _ when state.isLocked => strings.lblOtpLocked,
                  _ when state.wrongAttempts > 0 => strings.lblOtpWrong,
                  _ => null,
                },
                onChanged: (code) => setState(() => _code = code),
                onCompleted: cubit.verify,
              ),
            ),
            const _ResendCountdown(),
          ],
        ),
        button: BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) => StyledPrimaryButton(
            label: strings.btnContinue,
            isEnabled: OtpValidator.isComplete(_code) && !state.isLocked,
            isLoading:
                state.status == OtpStatus.verifying ||
                state.status == OtpStatus.verified,
            onTap: () => cubit.verify(_code),
          ),
        ),
      ),
    );
  }
}

class _ResendCountdown extends StatelessWidget {
  const _ResendCountdown();

  static String _format(Duration time) {
    final seconds = (time.inSeconds % Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0');
    return '${time.inMinutes}:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final state = context.watch<OtpCubit>().state;
    final style = context.textTheme.bodySmall;

    if (state.resendIn > Duration.zero || state.status == OtpStatus.sending) {
      return Text(strings.lblResendIn(_format(state.resendIn)), style: style);
    }
    return GestureDetector(
      onTap: context.read<OtpCubit>().resend,
      child: Text(
        strings.lblResentCounterResend,
        style: style?.copyWith(
          color: context.theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

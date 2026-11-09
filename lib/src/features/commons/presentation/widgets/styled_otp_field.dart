import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledOtpField extends StatefulWidget {
  final int length;
  final bool enabled;
  final int errorCount;
  final String? errorText;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;

  const StyledOtpField({
    super.key,
    required this.length,
    required this.onCompleted,
    this.onChanged,
    this.enabled = true,
    this.errorCount = 0,
    this.errorText,
  });

  @override
  State<StyledOtpField> createState() => _StyledOtpFieldState();
}

class _StyledOtpFieldState extends State<StyledOtpField>
    with SingleTickerProviderStateMixin {
  static const _maxBoxSize = 48.0;
  static const _shakeDistance = 12.0;
  static const _shakeTurns = 3;

  final _controller = TextEditingController();
  late final _shake = AnimationController(
    vsync: this,
    duration: AppMotion.shake,
  );

  @override
  void didUpdateWidget(StyledOtpField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorCount > oldWidget.errorCount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _controller.clear();
      });
      if (!MediaQuery.disableAnimationsOf(context)) _shake.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final available =
        min(context.width, AppSpacing.formMaxWidth) - 2 * AppInsets.md;
    final gaps = (widget.length - 1) * AppSpacing.xs;
    final boxSize = min((available - gaps) / widget.length, _maxBoxSize);

    return AnimatedBuilder(
      animation: _shake,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          sin(_shake.value * pi * 2 * _shakeTurns) *
              _shakeDistance *
              (1 - _shake.value),
          0,
        ),
        child: child,
      ),
      child: _pinput(context, boxSize),
    );
  }

  Widget _pinput(BuildContext context, double boxSize) {
    final colors = context.theme.colorScheme;
    final base = PinTheme(
      width: boxSize,
      height: boxSize,
      textStyle: context.textTheme.titleLarge,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.transparent),
      ),
    );
    final focused = base.copyBorderWith(
      border: Border.all(color: colors.primary),
    );

    return Pinput(
      length: widget.length,
      controller: _controller,
      enabled: widget.enabled,
      autofocus: true,
      keyboardType: TextInputType.number,
      separatorBuilder: (_) => const SizedBox(width: AppSpacing.xs),
      mainAxisAlignment: MainAxisAlignment.start,
      defaultPinTheme: base,
      focusedPinTheme: focused,
      submittedPinTheme: focused,
      errorPinTheme: base.copyBorderWith(
        border: Border.all(color: colors.error),
      ),
      forceErrorState: widget.errorText != null,
      errorText: widget.errorText,
      errorTextStyle: context.textTheme.bodySmall?.copyWith(
        color: colors.error,
      ),
      animationDuration: AppMotion.fast,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
    );
  }
}

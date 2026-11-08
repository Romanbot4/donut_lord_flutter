import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledProgressRing extends StatelessWidget {
  final int step;
  final int total;
  final bool isComplete;

  const StyledProgressRing({
    super.key,
    required this.step,
    required this.total,
    this.isComplete = false,
  });

  static const _size = 40.0;
  static const _stroke = 6.0;
  static const _trackAlpha = 0.3;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    return SizedBox.square(
      dimension: _size,
      child: AnimatedSwitcher(
        duration: AppMotion.fast,
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: isComplete
            ? Container(
                padding: EdgeInsets.all(AppInsets.xs),
                key: const ValueKey(true),
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded, color: colors.onPrimary),
              )
            : TweenAnimationBuilder<double>(
                key: const ValueKey(false),
                // Starts one step back so each page animates its own step in.
                tween: Tween(begin: (step - 1) / total, end: step / total),
                duration: AppMotion.medium,
                curve: AppMotion.entranceCurve,
                builder: (context, value, _) => CircularProgressIndicator(
                  value: value,
                  strokeWidth: _stroke,
                  strokeAlign: -1,
                  color: colors.primary,
                  backgroundColor: colors.secondary.withValues(
                    alpha: _trackAlpha,
                  ),
                ),
              ),
      ),
    );
  }
}

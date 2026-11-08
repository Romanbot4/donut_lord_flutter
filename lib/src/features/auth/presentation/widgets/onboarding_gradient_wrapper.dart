import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

/// Soft pink wash behind the auth screens.
class OnboardingGradientWrapper extends StatelessWidget {
  final Widget child;
  const OnboardingGradientWrapper({super.key, required this.child});

  static const _strongAlpha = 0.1;
  static const _softAlpha = 0.05;

  @override
  Widget build(BuildContext context) {
    final primary = context.theme.colorScheme.primary;

    return ColoredBox(
      color: context.theme.scaffoldBackgroundColor,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primary.withValues(alpha: _strongAlpha),
              primary.withValues(alpha: _softAlpha),
              primary.withValues(alpha: 0),
              primary.withValues(alpha: 0),
              primary.withValues(alpha: _strongAlpha),
            ],
            stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
          ),
        ),
        child: child,
      ),
    );
  }
}

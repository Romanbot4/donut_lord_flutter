import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class OnboardingSection extends StatelessWidget {
  final VoidCallback onTapStart;
  final VoidCallback onTapSocialLogIn;
  final bool animate;

  const OnboardingSection({
    super.key,
    required this.onTapStart,
    required this.onTapSocialLogIn,
    this.animate = true,
  });

  static const _fadeHeight = 120.0;
  static const _fadeStop = 0.8;

  @override
  Widget build(BuildContext context) {
    final background = context.theme.scaffoldBackgroundColor;
    final strings = context.localizations;

    return Column(
      children: [
        Container(
          height: _fadeHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, _fadeStop],
              colors: [background.withValues(alpha: 0), background],
            ),
          ),
        ),
        Container(
          color: background,
          padding: const EdgeInsets.all(AppInsets.md),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.sm,
              children: _staggered([
                Text(
                  strings.lblRoundFoodForEveryMood,
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                StyledPrimaryButton(
                  label: strings.lblLetsGetStarted,
                  onTap: onTapStart,
                ),
                _LogInLabel(onTap: onTapStart),
                OnboardingSocialButtons(onTap: onTapSocialLogIn),
                const TermsAgreementText(),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _staggered(List<Widget> children) => [
    for (final (index, child) in children.indexed)
      child.slideUpIn(
        enabled: animate,
        delay: AppMotion.medium + AppMotion.stagger * index,
        offset: AppMotion.contentSlideOffset,
      ),
  ];
}

class _LogInLabel extends StatelessWidget {
  final VoidCallback onTap;

  const _LogInLabel({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final style = context.textTheme.bodyMedium;

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "${strings.lblAlreadyHaveAnAccount} ",
        style: style,
        children: [
          TextSpan(
            text: strings.btnLogin,
            style: style?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.theme.colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

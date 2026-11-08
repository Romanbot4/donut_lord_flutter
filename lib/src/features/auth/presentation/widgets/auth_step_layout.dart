import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class AuthStepLayout extends StatelessWidget {
  final int step;
  final bool isComplete;
  final String title;
  final String? subtitle;
  final Widget body;
  final Widget button;

  const AuthStepLayout({
    super.key,
    required this.step,
    required this.title,
    required this.body,
    required this.button,
    this.subtitle,
    this.isComplete = false,
  });

  static const totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    return OnboardingGradientWrapper(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.formMaxWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppInsets.md),
                child: _content(context),
              ),
              // CustomScrollView(
              //   slivers: [
              //     SliverPadding(
              //       padding: const EdgeInsets.all(AppSpacing.md),
              //       sliver: SliverFillRemaining(
              //         hasScrollBody: false,
              //         child: _content(context),
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const StyledBackButton(),
            StyledProgressRing(
              step: step,
              total: totalSteps,
              isComplete: isComplete,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(title, style: context.textTheme.headlineLarge),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle!, style: context.textTheme.bodyMedium),
        ],
        const SizedBox(height: AppSpacing.md),
        body,
        const Spacer(),
        const SizedBox(height: AppSpacing.md),
        button,
        const SizedBox(height: AppSpacing.md),
        const TermsAgreementText(),
      ],
    );
  }
}

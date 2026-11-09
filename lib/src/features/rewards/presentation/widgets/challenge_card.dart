import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';
import 'package:jdonuts/src/features/rewards/presentation/presentation.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final Duration artworkDelay;

  const ChallengeCard({
    super.key,
    required this.challenge,
    this.artworkDelay = Duration.zero,
  });

  static const _artworkFlex = 2;
  static const _detailsFlex = 3;

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;

    return _CardShell(
      artwork: ChallengeArtwork(challenge: challenge, delay: artworkDelay),
      details: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          Text(challenge.title, style: context.textTheme.headlineSmall),
          Text(
            strings.lblChallengeProgress(challenge.current, challenge.target),
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _EarnButton(isComplete: challenge.isComplete),
              Text(
                strings.lblPointsShort(challenge.rewardPoints),
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EarnButton extends StatelessWidget {
  final bool isComplete;

  const _EarnButton({required this.isComplete});

  static const _pulseScale = 1.06;

  @override
  Widget build(BuildContext context) {
    final button = IntrinsicWidth(
      child: StyledPrimaryButton(
        label: context.localizations.btnEarn,
        isEnabled: isComplete,
        onTap: isComplete ? () {} : null,
      ),
    );

    if (!isComplete || MediaQuery.disableAnimationsOf(context)) return button;
    return button
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(
          begin: 1,
          end: _pulseScale,
          duration: AppMotion.attentionPulse,
          curve: Curves.easeInOut,
        );
  }
}

class ChallengeCardSkeleton extends StatelessWidget {
  const ChallengeCardSkeleton({super.key});

  static const _progressWidth = 48.0;
  static const _buttonWidth = 96.0;
  static const _buttonHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      artwork: const AspectRatio(
        aspectRatio: 1,
        child: StyledShimmer(shape: BoxShape.circle),
      ),
      details: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.xs,
          children: [
            StyledShimmer(
              width: constraints.maxWidth,
              height: context.lineHeight(context.textTheme.headlineSmall),
              radius: AppRadius.full,
            ),
            StyledShimmer(
              width: _progressWidth,
              height: context.lineHeight(context.textTheme.bodyLarge),
              radius: AppRadius.full,
            ),
            const StyledShimmer(
              width: _buttonWidth,
              height: _buttonHeight,
              radius: AppRadius.full,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget artwork;
  final Widget details;

  const _CardShell({required this.artwork, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppInsets.md),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        spacing: AppSpacing.md,
        children: [
          Expanded(flex: ChallengeCard._artworkFlex, child: artwork),
          Expanded(flex: ChallengeCard._detailsFlex, child: details),
        ],
      ),
    );
  }
}

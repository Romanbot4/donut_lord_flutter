import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class TierLadder extends StatelessWidget {
  final MemberTier currentTier;
  final double progressToNextTier;
  final int pointsToNextTier;

  const TierLadder({
    super.key,
    required this.currentTier,
    required this.progressToNextTier,
    required this.pointsToNextTier,
  });

  static const _badgeSize = 48.0;
  static const _connectorHeight = 56.0;
  static const _lineWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);
    const tiers = MemberTier.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, tier) in tiers.indexed) ...[
          _TierRow(
            tier: tier,
            status: _status(context, tier),
            isDimmed: tier.index > currentTier.index + 1,
          ).slideUpIn(
            enabled: animate,
            delay: AppMotion.tierStagger * index,
            offset: AppMotion.contentSlideOffset,
          ),
          if (index < tiers.length - 1)
            _Connector(
              fill: _segmentFill(index),
              animate: animate,
              delay: AppMotion.tierStagger * tiers.length,
            ),
        ],
      ],
    );
  }

  double _segmentFill(int index) {
    if (index < currentTier.index) return 1;
    if (index == currentTier.index) return progressToNextTier.clamp(0.0, 1.0);
    return 0;
  }

  String _status(BuildContext context, MemberTier tier) {
    final strings = context.localizations;
    if (tier == currentTier) return strings.lblYoureHereNow;
    if (tier.index == currentTier.index + 1) {
      final points = NumberFormat.decimalPattern(strings.localeName)
          .format(pointsToNextTier);
      return strings.lblPointsToBecomeTier(points, tier.label(context));
    }
    return strings.lblYoullBeHereSoon;
  }
}

class _TierRow extends StatelessWidget {
  final MemberTier tier;
  final String status;
  final bool isDimmed;

  const _TierRow({
    required this.tier,
    required this.status,
    required this.isDimmed,
  });

  static const _dimmedOpacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDimmed ? _dimmedOpacity : 1,
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          SvgPicture.asset(
            tier.badgeAsset,
            width: TierLadder._badgeSize,
            height: TierLadder._badgeSize,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tier.label(context), style: context.textTheme.titleLarge),
                Text(
                  status,
                  style: context.textTheme.bodySmall,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Connector extends StatelessWidget {
  final double fill;
  final bool animate;
  final Duration delay;

  const _Connector({
    required this.fill,
    required this.animate,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    const lineWidth = TierLadder._lineWidth;
    final fillColor =
        context.textTheme.titleLarge?.color ?? context.theme.primaryColor;

    Widget filled = FractionallySizedBox(
      heightFactor: fill,
      alignment: Alignment.topCenter,
      child: ColoredBox(color: fillColor),
    );
    if (animate && fill > 0) {
      filled = filled
          .animate(delay: delay)
          .scaleY(
            begin: 0,
            end: 1,
            alignment: Alignment.topCenter,
            duration: AppMotion.progressFill,
            curve: AppMotion.entranceCurve,
          );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: (TierLadder._badgeSize - lineWidth) / 2,
      ),
      child: SizedBox(
        width: lineWidth,
        height: TierLadder._connectorHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(lineWidth),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ColoredBox(color: context.theme.dividerColor),
              Align(alignment: Alignment.topCenter, child: filled),
            ],
          ),
        ),
      ),
    );
  }
}

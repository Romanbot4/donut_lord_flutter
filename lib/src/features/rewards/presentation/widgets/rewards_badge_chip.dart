import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class RewardsBadgeChip extends StatefulWidget {
  final int count;

  const RewardsBadgeChip({super.key, required this.count});

  @override
  State<RewardsBadgeChip> createState() => _RewardsBadgeChipState();
}

class _RewardsBadgeChipState extends State<RewardsBadgeChip> {
  static const _pressedScale = 0.94;
  static const _popFrom = 0.4;

  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final chip = Semantics(
      button: true,
      label: '${context.localizations.lblRewards} ${widget.count}',
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedScale(
          duration: AppMotion.fast,
          scale: _pressed ? _pressedScale : 1,
          alignment: Alignment.centerRight,
          child: _Pill(count: widget.count),
        ),
      ),
    );

    if (MediaQuery.disableAnimationsOf(context)) return chip;
    return chip
        .animate(delay: AppMotion.tierStagger)
        .fadeIn(duration: AppMotion.fast)
        .scale(
          begin: const Offset(_popFrom, _popFrom),
          end: const Offset(1, 1),
          alignment: Alignment.centerRight,
          duration: AppMotion.medium,
          curve: Curves.elasticOut,
        );
  }
}

class _Pill extends StatelessWidget {
  final int count;

  const _Pill({required this.count});

  static const _countSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.xs * 3 / 2,
        vertical: AppInsets.xxs * 3 / 2,
      ),
      decoration: const BoxDecoration(
        color: AppColors.accentOrange,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(AppRadius.full),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xxs,
        children: [
          Text(
            context.localizations.lblRewards,
            style: context.textTheme.bodyMedium?.bold.copyWith(
              color: AppColors.white,
            ),
          ),
          Container(
            width: _countSize,
            height: _countSize,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Text('$count', style: context.textTheme.labelMedium),
          ),
        ],
      ),
    );
  }
}

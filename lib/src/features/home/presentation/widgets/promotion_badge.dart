import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

class PromotionBadge extends StatelessWidget {
  final Promotion promotion;

  const PromotionBadge({super.key, required this.promotion});

  Alignment get _alignment => switch (promotion.position) {
    PromotionPosition.topLeft => Alignment.topLeft,
    PromotionPosition.topCenter => Alignment.topCenter,
    PromotionPosition.topRight => Alignment.topRight,
    PromotionPosition.bottomLeft => Alignment.bottomLeft,
    PromotionPosition.bottomCenter => Alignment.bottomCenter,
    PromotionPosition.bottomRight => Alignment.bottomRight,
  };

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(AppInsets.xs),
        child: Align(
          alignment: _alignment,
          child: PromotionPill(promotion: promotion),
        ),
      ),
    );
  }
}

class PromotionPill extends StatelessWidget {
  final Promotion promotion;

  const PromotionPill({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    final color = switch (promotion.kind) {
      PromotionKind.discount || PromotionKind.isNew => AppColors.accentOrange,
      PromotionKind.info => context.theme.colorScheme.primary,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.xs,
        vertical: AppInsets.xxs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.white),
      ),
      child: Text(
        promotion.label,
        style: context.textTheme.labelMedium?.copyWith(color: AppColors.white),
      ),
    );
  }
}

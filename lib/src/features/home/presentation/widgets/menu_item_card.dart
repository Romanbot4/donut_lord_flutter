import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final double width;
  final double cardAspectRatio;
  final VoidCallback? onTap;

  const MenuItemCard({
    super.key,
    required this.item,
    required this.width,
    required this.cardAspectRatio,
    this.onTap,
  });

  static const nameMaxLines = 2;

  static double heightFor(BuildContext context, double width, double ratio) =>
      width / ratio +
      AppSpacing.xs +
      context.lineHeight(context.textTheme.titleSmall, lines: nameMaxLines);

  @override
  Widget build(BuildContext context) {
    final promotion = item.promotion;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.xs,
          children: [
            AspectRatio(
              aspectRatio: cardAspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: ColoredBox(
                  color: context.theme.cardColor,
                  child: Stack(
                    children: [
                      Positioned.fill(child: StyledImage(item.imageUrl)),
                      if (promotion != null)
                        PromotionBadge(promotion: promotion),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              item.name,
              maxLines: nameMaxLines,
              style: context.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItemCardSkeleton extends StatelessWidget {
  final double width;
  final double cardAspectRatio;

  const MenuItemCardSkeleton({
    super.key,
    required this.width,
    required this.cardAspectRatio,
  });

  static const _nameWidthFactor = 0.7;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          AspectRatio(
            aspectRatio: cardAspectRatio,
            child: const StyledShimmer(radius: AppRadius.lg),
          ),
          StyledShimmer(
            width: width * _nameWidthFactor,
            height: context.lineHeight(context.textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}

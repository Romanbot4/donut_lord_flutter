import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';
import 'package:jdonuts/src/features/product/presentation/presentation.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final double width;
  final double cardAspectRatio;
  final String heroTag;

  const MenuItemCard({
    super.key,
    required this.item,
    required this.width,
    required this.cardAspectRatio,
    required this.heroTag,
  });

  void _openDetail(BuildContext context) => context.push(
    ProductDetailPage.pathFor(item.id),
    extra: ProductPreview(
      id: item.id,
      code: item.code,
      name: item.name,
      priceMmk: item.priceMmk,
      isNew: item.isNew,
      imageUrl: item.imageUrl,
      imageAspectRatio: item.imageAspectRatio,
      heroTag: heroTag,
    ),
  );

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
      onTap: () => _openDetail(context),
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
                      Positioned.fill(
                        child: Hero(
                          tag: heroTag,
                          child: StyledImage(item.imageUrl),
                        ),
                      ),
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

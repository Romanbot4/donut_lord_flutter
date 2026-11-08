import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class HomeNearbyShopsSection extends StatelessWidget {
  final List<Shop>? shops;
  final bool hasFailed;
  final VoidCallback onRetry;
  final double bottomInset;

  const HomeNearbyShopsSection({
    super.key,
    required this.shops,
    required this.hasFailed,
    required this.onRetry,
    required this.bottomInset,
  });

  static const _grassHeight = 72.0;
  static const _skeletonCards = 2;

  @override
  Widget build(BuildContext context) {
    final shops = this.shops;
    final cardWidth = context.width * HomeMenuSection.featuredWidthFactor;

    return ColoredBox(
      color: context.theme.colorScheme.secondary,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              HomeImages.nearbyShopsBackground,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.md,
            children: [
              const SizedBox(height: AppSpacing.xs),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.sm,
                  children: [
                    Text(
                      context.localizations.lblShopsNearYou(shops?.length ?? 0),
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.theme.colorScheme.onSecondary,
                      ),
                    ),
                    const _ExplorePill(),
                  ],
                ),
              ),
              if (hasFailed)
                StyledSectionError(onRetry: onRetry)
              else if (shops != null && shops.isEmpty)
                StyledSectionEmpty(onRefresh: onRetry)
              else
                SizedBox(
                  height: HomeNearbyShopCard.heightFor(context, cardWidth),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: shops == null
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppInsets.md,
                    ),
                    itemCount: shops?.length ?? _skeletonCards,
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (_, index) => shops == null
                        ? StyledShimmer(width: cardWidth, radius: AppRadius.lg)
                        : HomeNearbyShopCard(
                            shop: shops[index],
                            width: cardWidth,
                          ),
                  ),
                ),
              SizedBox(height: _grassHeight + bottomInset),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExplorePill extends StatelessWidget {
  const _ExplorePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.md,
        vertical: AppInsets.xs,
      ),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        context.localizations.btnExploreNow.toUpperCase(),
        style: context.textTheme.labelLarge?.copyWith(
          color: context.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

class HomeNearbyShopCard extends StatelessWidget {
  final Shop shop;
  final double width;

  const HomeNearbyShopCard({super.key, required this.shop, required this.width});

  static const _photoAspectRatio = 4 / 3;
  static const _addressMaxLines = 2;

  static double heightFor(BuildContext context, double width) {
    final text = context.textTheme;
    return AppInsets.sm +
        (width - 2 * AppInsets.sm) / _photoAspectRatio +
        AppSpacing.sm +
        context.lineHeight(text.titleSmall) +
        context.lineHeight(text.bodySmall, lines: _addressMaxLines) +
        AppSpacing.xxs +
        context.lineHeight(text.labelMedium) +
        AppInsets.sm;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = shop.imageUrl;

    return Container(
      width: width,
      padding: const EdgeInsets.all(AppInsets.sm),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: _photoAspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: imageUrl == null
                  ? const StyledShimmer(radius: 0)
                  : StyledImage(imageUrl),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(shop.name, maxLines: 1, style: context.textTheme.titleSmall),
          Text(
            shop.address,
            maxLines: _addressMaxLines,
            style: context.textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            context.localizations.btnOrderOnline,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

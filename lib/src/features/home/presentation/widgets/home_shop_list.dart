import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class HomeShopList extends StatelessWidget {
  final List<Shop> shops;
  final bool isLoading;
  final double cardWidth;

  const HomeShopList({
    super.key,
    required this.shops,
    required this.isLoading,
    required this.cardWidth,
  });

  static const aspectRatio = 4 / 3;
  static const _skeletonCount = 2;

  static double heightFor(double cardWidth) => cardWidth / aspectRatio;

  @override
  Widget build(BuildContext context) {
    final count = isLoading ? _skeletonCount : shops.length;
    const backgrounds = HomeImages.shopBackgrounds;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: isLoading ? const NeverScrollableScrollPhysics() : null,
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
      itemCount: count,
      separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
      itemBuilder: (context, index) => SizedBox(
        width: cardWidth,
        child: isLoading
            ? const StyledShimmer(radius: AppRadius.lg)
            : HomeShopCard(
                shop: shops[index],
                background: backgrounds[index % backgrounds.length],
              ),
      ),
    );
  }
}

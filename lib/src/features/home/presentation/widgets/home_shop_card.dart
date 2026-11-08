import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';

class HomeShopCard extends StatelessWidget {
  final Shop shop;
  final String background;

  const HomeShopCard({super.key, required this.shop, required this.background});

  static const _contentWidthFactor = 0.6;
  static const _photoWidthFactor = 0.8;
  static const _titleMaxLines = 2;
  static const _defaultPhotoRatio = 16 / 9;

  @override
  Widget build(BuildContext context) {
    final promotion = shop.promotion;
    final imageUrl = shop.imageUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(background, fit: BoxFit.cover),
          ),
          Positioned(
            top: AppInsets.sm,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.xs,
              children: [
                if (promotion != null) PromotionPill(promotion: promotion),
                FractionallySizedBox(
                  widthFactor: _contentWidthFactor,
                  child: Text(
                    shop.displayTitle,
                    textAlign: TextAlign.center,
                    maxLines: _titleMaxLines,
                    style: context.textTheme.headlineMedium?.bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                if (imageUrl != null)
                  FractionallySizedBox(
                    widthFactor: _photoWidthFactor,
                    child: _ShopPhoto(
                      imageUrl: imageUrl,
                      aspectRatio: shop.imageAspectRatio ?? _defaultPhotoRatio,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopPhoto extends StatelessWidget {
  final String imageUrl;
  final double aspectRatio;

  const _ShopPhoto({required this.imageUrl, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.lg);

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        foregroundDecoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: context.theme.colorScheme.onPrimary),
        ),
        child: ClipRRect(borderRadius: radius, child: StyledImage(imageUrl)),
      ),
    );
  }
}

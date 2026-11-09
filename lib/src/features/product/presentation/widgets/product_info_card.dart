import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/product/presentation/presentation.dart';

class ProductInfoCard extends StatelessWidget {
  final String? code;
  final String? name;
  final int? priceMmk;
  final bool isNew;
  final String? imageUrl;
  final double imageAspectRatio;
  final String heroTag;
  final Widget stepper;

  const ProductInfoCard({
    super.key,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.imageUrl,
    required this.imageAspectRatio,
    required this.heroTag,
    required this.stepper,
  });

  static const _imageWidthFactor = 0.7;
  static const _textSkeletonWidth = 200.0;

  @override
  Widget build(BuildContext context) {
    const stepperHeight = QuantityStepper.height;
    final text = context.textTheme;
    final imageUrl = this.imageUrl;
    final priceMmk = this.priceMmk;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: stepperHeight / 2),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            AppInsets.md,
            AppInsets.md,
            AppInsets.md,
            stepperHeight / 2 + AppInsets.md,
          ),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _maybe(context, code, text.bodySmall)),
                  if (isNew) const _NewBadge(),
                ],
              ),
              _maybe(context, name, text.headlineLarge),
              _maybe(
                context,
                priceMmk == null ? null : formatMmk(context, priceMmk),
                text.titleSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Center(
                child: FractionallySizedBox(
                  widthFactor: _imageWidthFactor,
                  child: Hero(
                    tag: heroTag,
                    child: AspectRatio(
                      aspectRatio: imageAspectRatio,
                      child: imageUrl == null
                          ? const StyledShimmer(radius: AppRadius.lg)
                          : StyledImage(imageUrl, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(left: 0, right: 0, bottom: 0, child: Center(child: stepper)),
      ],
    );
  }

  Widget _maybe(BuildContext context, String? value, TextStyle? style) =>
      value == null
      ? StyledShimmer(
          width: _textSkeletonWidth,
          height: context.lineHeight(style),
          radius: AppRadius.full,
        )
      : Text(value, style: style);
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.xs,
        vertical: AppInsets.xxs / 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentOrange,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        context.localizations.lblNew,
        style: context.textTheme.labelMedium?.copyWith(color: AppColors.white),
      ),
    );
  }
}

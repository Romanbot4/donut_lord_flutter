import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final BoxShape shape;

  const StyledShimmer({
    super.key,
    this.width,
    this.height,
    this.radius = AppRadius.md,
    this.shape = BoxShape.rectangle,
  });

  static const _sweepSize = 4.0;
  static const _softAlpha = 12;
  static const _strongAlpha = 24;

  @override
  Widget build(BuildContext context) {
    final borderRadius = shape == BoxShape.circle
        ? BorderRadius.circular(AppRadius.full)
        : BorderRadius.circular(radius);
    final placeholder = ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadius,
        ),
      ),
    );

    if (MediaQuery.disableAnimationsOf(context)) return placeholder;

    final tint = context.textTheme.bodyMedium!.color!;
    return placeholder
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          padding: 0,
          duration: AppMotion.shimmer,
          size: _sweepSize,
          color: tint.withAlpha(_strongAlpha),
          colors: [
            tint.withAlpha(_softAlpha),
            tint.withAlpha(_strongAlpha),
            tint.withAlpha(_softAlpha),
          ],
        );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledImage extends StatelessWidget {
  final String source;
  final BoxFit fit;

  const StyledImage(this.source, {super.key, this.fit = BoxFit.cover});

  static const _bundledPrefix = 'assets/';

  @override
  Widget build(BuildContext context) {
    if (source.startsWith(_bundledPrefix)) {
      return Image.asset(
        source,
        fit: fit,
        errorBuilder: (_, _, _) => const _ImageError(),
      );
    }
    return CachedNetworkImage(
      imageUrl: source,
      fit: fit,
      placeholder: (_, _) => const StyledShimmer(radius: 0),
      errorWidget: (_, _, _) => const _ImageError(),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.neutral100,
      child: Center(
        child: Icon(Icons.broken_image_outlined, color: AppColors.neutral400),
      ),
    );
  }
}

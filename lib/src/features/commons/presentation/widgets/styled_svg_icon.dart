import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledSvgIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color? color;

  const StyledSvgIcon(
    this.asset, {
    super.key,
    this.size = defaultSize,
    this.color,
  });

  static const defaultSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        color ?? context.theme.iconTheme.color!,
        BlendMode.srcIn,
      ),
    );
  }
}

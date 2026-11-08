import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class OnboardingSocialButtons extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingSocialButtons({super.key, required this.onTap});

  static const _logoSize = 40.0;

  @override
  Widget build(BuildContext context) {
    const logos = [
      AuthImages.googleLogo,
      AuthImages.appleLogo,
      AuthImages.facebookLogo,
    ];

    return Row(
      spacing: AppSpacing.md,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final logo in logos)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppInsets.xxs),
              child: SvgPicture.asset(
                logo,
                width: _logoSize,
                height: _logoSize,
              ),
            ),
          ),
      ],
    );
  }
}

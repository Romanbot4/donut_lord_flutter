import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledOfflineBanner extends StatelessWidget {
  final bool isOffline;

  const StyledOfflineBanner({super.key, required this.isOffline});

  static const _iconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppMotion.fast,
      curve: AppMotion.entranceCurve,
      child: !isOffline
          ? const SizedBox(width: double.infinity)
          : Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(
                AppInsets.md,
                AppInsets.sm,
                AppInsets.md,
                0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.sm,
                vertical: AppInsets.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Row(
                spacing: AppSpacing.xs,
                children: [
                  Icon(
                    Icons.cloud_off_rounded,
                    size: _iconSize,
                    color: AppColors.white,
                  ),
                  Expanded(
                    child: Text(
                      context.localizations.lblOffline,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

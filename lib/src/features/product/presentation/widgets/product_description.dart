import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class ProductDescription extends StatelessWidget {
  final String? description;
  final bool hasFailed;
  final VoidCallback onRetry;

  const ProductDescription({
    super.key,
    required this.description,
    required this.hasFailed,
    required this.onRetry,
  });

  static const _skeletonLines = 4;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.textTheme.bodySmall?.color,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          const _WhatsThisLabel(),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: context.theme.cardColor,
          ),
          Expanded(
            child: switch ((description, hasFailed)) {
              (final text?, _) => Text(
                text * 100,
                style: bodyStyle,
                overflow: TextOverflow.visible,
              ),
              (null, true) => GestureDetector(
                onTap: onRetry,
                child: Text(
                  context.localizations.lblRefresh,
                  style: bodyStyle?.copyWith(
                    color: context.theme.colorScheme.primary,
                  ),
                ),
              ),
              (null, false) => Column(
                spacing: AppSpacing.xxs,
                children: [
                  for (var line = 0; line < _skeletonLines; line++)
                    StyledShimmer(
                      height: context.lineHeight(bodyStyle),
                      radius: AppRadius.full,
                    ),
                ],
              ),
            },
          ),
        ],
      ),
    );
  }
}

class _WhatsThisLabel extends StatelessWidget {
  const _WhatsThisLabel();

  static const _width = 56.0;
  static const _iconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xxs,
        children: [
          Container(
            width: _iconSize,
            height: _iconSize,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
            ),
            child: Text(
              '?',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          Text(
            context.localizations.lblWhatsThis,
            style: context.textTheme.titleSmall,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}

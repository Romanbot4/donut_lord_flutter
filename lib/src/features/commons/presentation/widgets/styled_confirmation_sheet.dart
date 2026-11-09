import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledConfirmationSheet extends StatelessWidget {
  final String title;
  final String description;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  const StyledConfirmationSheet({
    super.key,
    required this.title,
    required this.description,
    required this.confirmLabel,
    required this.cancelLabel,
    this.isDestructive = false,
  });

  static const _maxWidth = 400.0;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String description,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive = false,
  }) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      backgroundColor: AppColors.transparent,
      constraints: BoxConstraints(maxWidth: min(_maxWidth, context.width)),
      builder: (_) => StyledConfirmationSheet(
        title: title,
        description: description,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(AppInsets.sm);
    final navigator = Navigator.of(context);

    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: padding,
                  child: Text(
                    title,
                    style: context.textTheme.headlineMedium?.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () => navigator.pop(false),
                child: const Padding(
                  padding: padding,
                  child: StyledSvgIcon(AppIcons.closeLinear),
                ),
              ),
            ],
          ),
          Padding(
            padding: padding.copyWith(top: 0),
            child: Text(
              description,
              overflow: TextOverflow.visible,
              style: context.textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: padding.copyWith(top: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpacing.sm,
              children: [
                StyledPrimaryButton(
                  label: confirmLabel,
                  color: isDestructive ? AppColors.red : null,
                  onTap: () => navigator.pop(true),
                ),
                TextButton(
                  onPressed: () => navigator.pop(false),
                  child: Text(
                    cancelLabel.toUpperCase(),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.padding.bottom),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledSectionError extends StatelessWidget {
  final VoidCallback onRetry;

  const StyledSectionError({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return _SectionMessage(
      icon: Icons.error_outline_rounded,
      message: context.localizations.lblSectionError,
      actionLabel: context.localizations.lblRefresh,
      onAction: onRetry,
    );
  }
}

class StyledSectionEmpty extends StatelessWidget {
  final VoidCallback? onRefresh;

  const StyledSectionEmpty({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return _SectionMessage(
      icon: Icons.inbox_outlined,
      message: context.localizations.lblSectionEmpty,
      actionLabel: context.localizations.lblRefresh,
      onAction: onRefresh,
    );
  }
}

class _SectionMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  final String actionLabel;
  final VoidCallback? onAction;

  const _SectionMessage({
    required this.icon,
    required this.message,
    required this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppInsets.md),
      padding: const EdgeInsets.all(AppInsets.sm),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        spacing: AppSpacing.xs,
        children: [
          Icon(icon, color: AppColors.grey),
          Expanded(child: Text(message, style: context.textTheme.bodyMedium)),
          if (onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    );
  }
}

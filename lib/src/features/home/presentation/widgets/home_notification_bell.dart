import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class HomeNotificationBell extends StatelessWidget {
  final int unreadCount;
  final VoidCallback? onTap;

  const HomeNotificationBell({
    super.key,
    required this.unreadCount,
    this.onTap,
  });

  static const _countSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${context.localizations.lblNotifications}: $unreadCount',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppInsets.xs * 1.5,
            vertical: AppInsets.xxs * 3 / 2,
          ).copyWith(right: AppInsets.xxs),
          decoration: BoxDecoration(
            color: AppColors.accentOrange,
            border: Border(
              left: BorderSide(color: context.theme.cardColor),
              top: BorderSide(color: context.theme.cardColor),
              bottom: BorderSide(color: context.theme.cardColor),
            ),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(AppRadius.full),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.xxs,
            children: [
              const StyledSvgIcon(
                AppIcons.notificationLinear,
                color: AppColors.white,
              ),
              if (unreadCount > 0)
                Container(
                  width: _countSize,
                  height: _countSize,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$unreadCount',
                    style: context.textTheme.labelMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// TODO: swap the margin below for a spacing token once styles come over.
abstract interface class Snacks {
  static const _horizontalMargin = 16.0;

  static void _showMessage(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
    Color? backgroundColor,
    Color? textColor,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: context.width - (2 * _horizontalMargin),
            ),
            decoration: BoxDecoration(
              color: backgroundColor ?? context.theme.cardColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: textColor ?? context.theme.primaryColor,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  static void info(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
  }) {
    _showMessage(
      context,
      message: message,
      gravity: gravity,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
    );
  }

  static void error(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
  }) {
    _showMessage(
      context,
      message: message,
      gravity: gravity,
      backgroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  static void success(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
  }) {
    _showMessage(
      context,
      message: message,
      gravity: gravity,
      backgroundColor: AppColors.success,
      textColor: AppColors.white,
    );
  }
}

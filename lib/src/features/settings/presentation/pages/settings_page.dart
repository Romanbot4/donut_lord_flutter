import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/cart/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String routePath = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(
            AppInsets.md,
          ).copyWith(bottom: context.padding.bottom + AppInsets.lg),
          children: [
            Text(
              context.localizations.lblSettings,
              style: context.textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _AccountCard(),
            const SizedBox(height: AppSpacing.md),
            const _LogOutRow(),
          ],
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard();

  static const _avatarRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (SessionCubit session) => switch (session.state) {
        SessionAuthenticated(:final user) => user,
        _ => null,
      },
    );
    if (user == null) return const SizedBox.shrink();

    final name = user.name.trim();
    final colors = context.theme.colorScheme;

    return _SettingsCard(
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          CircleAvatar(
            radius: _avatarRadius,
            backgroundColor: colors.primary,
            child: Text(
              name.isEmpty ? '?' : name.characters.first.toUpperCase(),
              style: context.textTheme.titleLarge?.copyWith(
                color: colors.onPrimary,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xxs,
              children: [
                Text(user.name, style: context.textTheme.titleLarge),
                Text(user.identifier, style: context.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogOutRow extends StatelessWidget {
  const _LogOutRow();

  static const _chevronSize = 16.0;

  Future<void> _confirmLogOut(BuildContext context) async {
    final strings = context.localizations;
    final confirmed = await StyledConfirmationSheet.show(
      context,
      title: strings.lblLogOutConfirmTitle,
      description: strings.lblLogOutConfirmDescription,
      confirmLabel: strings.lblLogOut,
      cancelLabel: strings.btnCancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final cart = context.read<CartCubit>();
    await context.read<SessionCubit>().logOut();
    await cart.clear();
  }

  @override
  Widget build(BuildContext context) {
    final destructive = context.theme.colorScheme.error;

    return _SettingsCard(
      child: Semantics(
        button: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: () => _confirmLogOut(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppInsets.xs),
            child: Row(
              spacing: AppSpacing.sm,
              children: [
                StyledSvgIcon(AppIcons.logoutLinear, color: destructive),
                Expanded(
                  child: Text(
                    context.localizations.lblLogOut,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: destructive,
                    ),
                  ),
                ),
                StyledSvgIcon(
                  AppIcons.chevronRightLinear,
                  color: destructive,
                  size: _chevronSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.cardColor,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: const EdgeInsets.all(AppInsets.sm), child: child),
    );
  }
}

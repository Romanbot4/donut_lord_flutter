import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String routePath = "/settings";

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          AppInsets.md,
          AppInsets.md,
          AppInsets.md,
          IndexLayout.bottomInset(context),
        ),
        children: [
          Text(strings.lblSettings, style: context.textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.md),
          Material(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: context.theme.colorScheme.error,
              ),
              title: Text(strings.lblLogOut),
              subtitle: Text(strings.lblLogOutConfirmDescription),
              onTap: context.read<SessionCubit>().logOut,
            ),
          ),
        ],
      ),
    );
  }
}

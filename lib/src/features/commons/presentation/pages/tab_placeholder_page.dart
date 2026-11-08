import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class TabPlaceholderPage extends StatelessWidget {
  final String title;

  const TabPlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xs,
        children: [
          Text(title, style: context.textTheme.headlineMedium),
          Text(
            context.localizations.lblComingSoon,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

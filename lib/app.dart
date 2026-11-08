import 'package:flutter/material.dart';
import 'package:jdonuts/flavors.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class JDonutsApp extends StatelessWidget {
  final ILocalization localization;
  final IAppRouter router;

  const JDonutsApp({
    super.key,
    required this.localization,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(context, locale: localization.locale);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: F.title,
      locale: localization.locale,
      localizationsDelegates: localization.localizationsDelegates,
      supportedLocales: localization.supportedLocales,
      theme: theme.light,
      darkTheme: theme.dark,
      routerConfig: router.router,
    );
  }
}

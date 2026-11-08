import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/flavors.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class JDonutsApp extends StatelessWidget {
  final ILocalization localization;
  final IAppRouter router;
  final SessionCubit session;

  const JDonutsApp({
    super.key,
    required this.localization,
    required this.router,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(context, locale: localization.locale);

    return BlocProvider.value(
      value: session,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: F.title,
        locale: localization.locale,
        localizationsDelegates: localization.localizationsDelegates,
        supportedLocales: localization.supportedLocales,
        themeMode: ThemeMode.light,
        theme: theme.light,
        darkTheme: theme.dark,
        routerConfig: router.router,
      ),
    );
  }
}

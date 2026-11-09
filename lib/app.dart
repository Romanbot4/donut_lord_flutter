import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdonuts/flavors.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/cart/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class JDonutsApp extends StatelessWidget {
  final ILocalization localization;
  final IAppRouter router;
  final SessionCubit session;
  final CartCubit cart;

  const JDonutsApp({
    super.key,
    required this.localization,
    required this.router,
    required this.session,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(context, locale: localization.locale);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: session),
        BlocProvider.value(value: cart),
      ],
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

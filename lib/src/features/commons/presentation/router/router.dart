import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/flavors.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

@Injectable(as: IAppRouter)
final class AppRouter implements IAppRouter {
  final ISnackShower _snackShower;
  final INavigationKeyProvider _navigationKeyProvider;
  AppRouter(this._navigationKeyProvider, this._snackShower);

  late final Uri _initialLocation = Uri.parse("/");

  void _goToInitialLocation(BuildContext context) =>
      context.go(_initialLocation.toString());

  @override
  RouterConfig<Object> get router => _goRouter;

  Uri? _location;

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: _navigationKeyProvider.globalKey,
    initialLocation: _initialLocation.toString(),
    redirect: (context, state) {
      _location = state.uri;
      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: _navigationKeyProvider.shellRouteKey,
        builder: (context, state, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (_, _) => _handleIndexLayoutPop(context),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: _initialLocation.path,
            builder: (context, state) =>
                Scaffold(body: Center(child: Text(F.title))),
          ),
        ],
      ),
    ],
  );

  DateTime? lastBackPressTime;

  void _handleIndexLayoutPop(BuildContext context) {
    if (_location?.path != _initialLocation.path) {
      _goToInitialLocation(context);
      return;
    }

    final now = DateTime.now();
    const thresholdInterval = Duration(seconds: 2);

    if (lastBackPressTime == null ||
        now.difference(lastBackPressTime!) > thresholdInterval) {
      lastBackPressTime = now;
      _snackShower.info(message: context.localizations.lblPressAgainToExit);
      return;
    }

    exit(0);
  }
}

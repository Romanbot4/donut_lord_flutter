import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/flavors.dart';
import 'package:jdonuts/src/di/di.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

@Injectable(as: IAppRouter)
final class AppRouter implements IAppRouter {
  final ISnackShower _snackShower;
  final INavigationKeyProvider _navigationKeyProvider;
  final SessionCubit _session;
  AppRouter(this._navigationKeyProvider, this._snackShower, this._session);

  late final Uri _initialLocation = Uri.parse("/");

  static const _signedOutPaths = {
    OnboardingPage.routePath,
    PhonePage.routePath,
    OtpPage.routePath,
  };

  static const _profileSteps = {
    UserNamePage.routePath,
    DateOfBirthPage.routePath,
  };

  late final _sessionChanges = StreamListenable(_session.stream);

  void _goToInitialLocation(BuildContext context) =>
      context.go(_initialLocation.toString());

  @override
  RouterConfig<Object> get router => _goRouter;

  Uri? _location;

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: _navigationKeyProvider.globalKey,
    initialLocation: _initialLocation.toString(),
    refreshListenable: _sessionChanges,
    redirect: (context, state) {
      _location = state.uri;
      return _guard(state.uri.path);
    },
    routes: [
      ..._authRoutes,
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

  late final List<GoRoute> _authRoutes = [
    GoRoute(
      path: OnboardingPage.routePath,
      pageBuilder: (context, state) => _fadePage(state, const OnboardingPage()),
    ),
    GoRoute(
      path: PhonePage.routePath,
      pageBuilder: (context, state) => _slidePage(state, const PhonePage()),
    ),
    GoRoute(
      path: OtpPage.routePath,
      pageBuilder: (context, state) => _slidePage(
        state,
        BlocProvider(
          create: (_) => inject<OtpCubit>(),
          child: OtpPage(
            phoneNumber: state.uri.queryParameters[OtpPage.phoneParam]!,
          ),
        ),
      ),
    ),
    GoRoute(
      path: UserNamePage.routePath,
      pageBuilder: (context, state) => _slidePage(
        state,
        BlocProvider(
          create: (_) => inject<UserNameCubit>(),
          child: const UserNamePage(),
        ),
      ),
    ),
    GoRoute(
      path: DateOfBirthPage.routePath,
      pageBuilder: (context, state) => _slidePage(
        state,
        BlocProvider(
          create: (_) => inject<DateOfBirthCubit>(),
          child: const DateOfBirthPage(),
        ),
      ),
    ),
    GoRoute(
      path: WelcomePage.routePath,
      pageBuilder: (context, state) => _fadePage(state, const WelcomePage()),
    ),
  ];

  String? _guard(String path) {
    final session = _session.state;
    if (session is! SessionAuthenticated) {
      return _signedOutPaths.contains(path) ? null : OnboardingPage.routePath;
    }
    final user = session.user;
    if (user.name.trim().isEmpty) {
      return path == UserNamePage.routePath ? null : UserNamePage.routePath;
    }
    if (user.dateOfBirth == null) {
      return _profileSteps.contains(path) ? null : DateOfBirthPage.routePath;
    }
    return _signedOutPaths.contains(path) ? _initialLocation.path : null;
  }

  static Page<void> _slidePage(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: AppMotion.fast,
      transitionsBuilder: (context, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: AppMotion.entranceCurve,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(AppMotion.contentSlideOffset, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  static Page<void> _fadePage(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: AppMotion.medium,
      transitionsBuilder: (context, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

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

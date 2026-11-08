import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/di/di.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/home/presentation/presentation.dart';
import 'package:jdonuts/src/features/settings/presentation/presentation.dart';

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

  static const _rewardsPath = "/rewards";
  static const _orderPath = "/order";
  static const _walletPath = "/wallet";

  static const _tabPaths = [
    HomePage.routePath,
    _rewardsPath,
    _orderPath,
    _walletPath,
    SettingsPage.routePath,
  ];

  late final _selectedTabIndex = ValueNotifier<int>(0);

  static GoRoute _tabRoute(String path, WidgetBuilder builder) => GoRoute(
    path: path,
    pageBuilder: (context, state) =>
        NoTransitionPage(key: state.pageKey, child: builder(context)),
  );

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
          final currentIndex = _tabPaths.indexOf(state.uri.path);
          if (currentIndex != -1 &&
              _selectedTabIndex.value != currentIndex) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _selectedTabIndex.value = currentIndex;
            });
          }

          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (_, _) => _handleIndexLayoutPop(context),
            child: IndexLayout(
              indexListener: _selectedTabIndex,
              showBottomNavigationBar: _tabPaths.contains(state.fullPath),
              onTap: (index) => context.go(_tabPaths[index]),
              child: child,
            ),
          );
        },
        routes: [
          _tabRoute(HomePage.routePath, (_) => const HomePage()),
          _tabRoute(
            _rewardsPath,
            (context) =>
                TabPlaceholderPage(title: context.localizations.lblReward),
          ),
          _tabRoute(
            _orderPath,
            (context) =>
                TabPlaceholderPage(title: context.localizations.lblOrder),
          ),
          _tabRoute(
            _walletPath,
            (context) =>
                TabPlaceholderPage(title: context.localizations.lblWallet),
          ),
          _tabRoute(SettingsPage.routePath, (_) => const SettingsPage()),
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

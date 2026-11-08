import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

@LazySingleton(as: INavigationKeyProvider)
class NavigationKeyProvider implements INavigationKeyProvider {
  late final _globalKey = GlobalKey<NavigatorState>();
  late final _shellRouteKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get globalKey => _globalKey;

  @override
  GlobalKey<NavigatorState> get shellRouteKey => _shellRouteKey;

  @override
  BuildContext? get scaffoldContext => _shellRouteKey.currentState?.context;
}

import 'package:flutter/material.dart';

abstract interface class INavigationKeyProvider {
  GlobalKey<NavigatorState> get globalKey;
  GlobalKey<NavigatorState> get shellRouteKey;
  BuildContext? get scaffoldContext;
}

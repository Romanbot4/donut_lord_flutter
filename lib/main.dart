import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdonuts/app.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/di/di.dart';
import 'package:jdonuts/src/features/auth/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';

import 'flavors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = Flavor.values.firstWhere(
    (e) => e.name == appFlavor,
    orElse: () => Flavor.prod,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await configureDependencies(environment: AuthConfig.backend);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    JDonutsApp(
      localization: inject<ILocalization>(),
      router: inject<IAppRouter>(),
      session: inject<SessionCubit>(),
    ),
  );
}

import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

@module
abstract class DatabaseProvider {
  @lazySingleton
  AppDatabase provideDatabase() => AppDatabase(driftDatabase(name: 'jdonuts'));

  @lazySingleton
  AssetBundle provideAssetBundle() => rootBundle;
}

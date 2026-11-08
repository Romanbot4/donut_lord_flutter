import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/home/data/data.dart';

@module
abstract class HomeApiClientProvider {
  @lazySingleton
  HomeApiClient provide(Dio dio) =>
      HomeApiClient(dio, baseUrl: FlavorizedNetworkConfig.baseUrl);
}

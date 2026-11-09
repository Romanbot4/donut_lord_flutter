import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/rewards/data/data.dart';

@module
abstract class RewardsApiClientProvider {
  @lazySingleton
  RewardsApiClient provide(Dio dio) =>
      RewardsApiClient(dio, baseUrl: FlavorizedNetworkConfig.baseUrl);
}

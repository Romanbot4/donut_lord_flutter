import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/config/config.dart';
import 'package:jdonuts/src/features/product/data/data.dart';

@module
abstract class ProductApiClientProvider {
  @lazySingleton
  ProductApiClient provide(Dio dio) =>
      ProductApiClient(dio, baseUrl: FlavorizedNetworkConfig.baseUrl);
}

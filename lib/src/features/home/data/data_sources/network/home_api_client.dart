import 'package:dio/dio.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';

@RestApi()
abstract class HomeApiClient {
  factory HomeApiClient(Dio dio, {required String baseUrl}) = _HomeApiClient;

  @GET("/v1/home")
  Future<ApiEnvelope<HomeFeedModel>> getHomeFeed();
}

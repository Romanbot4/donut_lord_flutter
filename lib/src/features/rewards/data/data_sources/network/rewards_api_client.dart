import 'package:dio/dio.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/rewards/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'rewards_api_client.g.dart';

@RestApi()
abstract class RewardsApiClient {
  factory RewardsApiClient(Dio dio, {required String baseUrl}) =
      _RewardsApiClient;

  @GET("/v1/rewards/challenges")
  Future<ApiEnvelope<ChallengesModel>> getChallenges();
}

import 'package:dio/dio.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/product/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api_client.g.dart';

@RestApi()
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {required String baseUrl}) =
      _ProductApiClient;

  @GET("/v1/products/{id}")
  Future<ApiEnvelope<ProductDetailModel>> getProduct(@Path("id") String id);
}

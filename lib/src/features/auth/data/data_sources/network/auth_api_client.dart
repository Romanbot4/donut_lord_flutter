import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jdonuts/src/features/auth/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {required String baseUrl}) = _AuthApiClient;

  @GET("/user/me")
  Future<UserModel> getMe();

  @POST("/auth/send-otp")
  @Extra({AuthExtra.skipAuth: true})
  Future<SendOtpResponse> sendOtp(@Body() SendOtpRequest body);

  @POST("/auth/verify-otp")
  @Extra({AuthExtra.skipAuth: true})
  Future<AuthorizedResponse> verifyOtp(@Body() VerifyOtpRequest body);

  @POST("/auth/refresh-token")
  @Extra({AuthExtra.skipAuth: true})
  Future<TokenResponse> refreshToken(@Body() RefreshTokenRequest body);

  @PUT("/user/frontend/{id}")
  @MultiPart()
  Future<UserModel> updateUserInfo(
    @Path("id") String id,
    @Part(name: "Name") String? name,
    @Part(name: "Password") String? password,
    @Part(name: "ProfilePicture") File? profilePicture,
    @Part(name: "DateOfBirth") String? dateOfBirth,
  );
}

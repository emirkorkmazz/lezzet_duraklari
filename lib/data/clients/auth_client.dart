import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/core/core.dart';
import '/data/data.dart';

part 'auth_client.g.dart';

@RestApi()

/// Auth Servisler
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  ///
  @POST(AppUrls.register)
  Future<RegisterResponse> registerUser(@Body() RegisterRequest request);

  ///
  @POST(AppUrls.login)
  Future<LoginResponse> loginUser(@Body() LoginRequest request);
}

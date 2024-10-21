import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/core/core.dart';
import '/data/data.dart';

part 'restaurant_client.g.dart';

@RestApi()

/// Auth Servisler
abstract class RestaurantClient {
  factory RestaurantClient(Dio dio, {String baseUrl}) = _RestaurantClient;

  ///
  @POST(AppUrls.addRestaurant)
  Future<AddRestaurantResponse> addRestaurant(
      @Body() AddRestaurantRequest request);

  ///
  /// @POST(AppUrls.login)
  /// Future<LoginResponse> loginUser(@Body() LoginRequest request);
}

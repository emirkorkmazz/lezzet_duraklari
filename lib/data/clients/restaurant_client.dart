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
  @POST(AppUrls.addMenuPhotos)
  Future<AddMenuPhotosResponse> addMenuPhotos(
      @Body() AddMenuPhotosRequest request);

  ///
  @POST(AppUrls.getMenuPhotos)
  Future<GetMenuPhotosResponse> getMenuPhotos(
      @Body() GetMenuPhotosRequest request);

  @DELETE(AppUrls.deleteMenuPhoto)
  Future<DeleteMenuPhotoResponse> deleteMenuPhoto(
      @Body() DeleteMenuPhotoRequest request);
}

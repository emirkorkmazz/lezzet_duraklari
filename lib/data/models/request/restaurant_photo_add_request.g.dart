// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_photo_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantPhotoAddRequest _$RestaurantPhotoAddRequestFromJson(
        Map<String, dynamic> json) =>
    RestaurantPhotoAddRequest(
      restaurantId: json['restaurantId'] as String?,
      photosBase64: (json['photosBase64'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RestaurantPhotoAddRequestToJson(
        RestaurantPhotoAddRequest instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'photosBase64': instance.photosBase64,
    };

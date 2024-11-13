// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_photo_add_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantPhotoAddResponse _$RestaurantPhotoAddResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantPhotoAddResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RestaurantPhotoAddResponseToJson(
        RestaurantPhotoAddResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'photoUrls': instance.photoUrls,
    };

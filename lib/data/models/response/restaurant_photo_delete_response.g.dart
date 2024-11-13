// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_photo_delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantPhotoDeleteResponse _$RestaurantPhotoDeleteResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantPhotoDeleteResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$RestaurantPhotoDeleteResponseToJson(
        RestaurantPhotoDeleteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

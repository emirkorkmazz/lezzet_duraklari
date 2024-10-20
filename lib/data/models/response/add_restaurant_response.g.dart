// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_restaurant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRestaurantResponse _$AddRestaurantResponseFromJson(
        Map<String, dynamic> json) =>
    AddRestaurantResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      restaurantId: json['restaurantId'] as String?,
    );

Map<String, dynamic> _$AddRestaurantResponseToJson(
        AddRestaurantResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'restaurantId': instance.restaurantId,
    };

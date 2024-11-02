// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantUpdateResponse _$RestaurantUpdateResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantUpdateResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$RestaurantUpdateResponseToJson(
        RestaurantUpdateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

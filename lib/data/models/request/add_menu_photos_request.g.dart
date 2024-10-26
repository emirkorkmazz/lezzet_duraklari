// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_menu_photos_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMenuPhotosRequest _$AddMenuPhotosRequestFromJson(
        Map<String, dynamic> json) =>
    AddMenuPhotosRequest(
      restaurantId: json['restaurantId'] as String?,
      menu1: json['menu1'] as String?,
      menu2: json['menu2'] as String?,
      menu3: json['menu3'] as String?,
    );

Map<String, dynamic> _$AddMenuPhotosRequestToJson(
        AddMenuPhotosRequest instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'menu1': instance.menu1,
      'menu2': instance.menu2,
      'menu3': instance.menu3,
    };

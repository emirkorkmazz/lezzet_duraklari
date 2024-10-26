// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_menu_photo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteMenuPhotoRequest _$DeleteMenuPhotoRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteMenuPhotoRequest(
      restaurantId: json['restaurantId'] as String?,
      menuNumber: json['menuNumber'] as String?,
    );

Map<String, dynamic> _$DeleteMenuPhotoRequestToJson(
        DeleteMenuPhotoRequest instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'menuNumber': instance.menuNumber,
    };

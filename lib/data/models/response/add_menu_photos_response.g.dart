// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_menu_photos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMenuPhotosResponse _$AddMenuPhotosResponseFromJson(
        Map<String, dynamic> json) =>
    AddMenuPhotosResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      updatedMenus: (json['updatedMenus'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AddMenuPhotosResponseToJson(
        AddMenuPhotosResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'updatedMenus': instance.updatedMenus,
    };

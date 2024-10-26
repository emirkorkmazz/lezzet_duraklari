// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_menu_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteMenuPhotoResponse _$DeleteMenuPhotoResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteMenuPhotoResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeleteMenuPhotoResponseToJson(
        DeleteMenuPhotoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

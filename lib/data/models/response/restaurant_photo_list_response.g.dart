// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_photo_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantPhotoListResponse _$RestaurantPhotoListResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantPhotoListResponse(
      status: json['status'] as bool?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantPhotoListResponseToJson(
        RestaurantPhotoListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'photos': instance.photos,
    };

Photos _$PhotosFromJson(Map<String, dynamic> json) => Photos(
      id: json['id'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$PhotosToJson(Photos instance) => <String, dynamic>{
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt,
    };

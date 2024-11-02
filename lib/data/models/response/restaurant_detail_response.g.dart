// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDetailResponse _$RestaurantDetailResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantDetailResponse(
      status: json['status'] as bool?,
      restaurant: json['restaurant'] == null
          ? null
          : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RestaurantDetailResponseToJson(
        RestaurantDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'restaurant': instance.restaurant,
      'photos': instance.photos,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      contact: json['contact'] as String?,
      logoUrl: json['logoUrl'] as String?,
      ownerId: json['ownerId'] as String?,
      isApproved: (json['isApproved'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      menu1: json['menu1'] as String?,
      menu2: json['menu2'] as String?,
      menu3: json['menu3'] as String?,
      favoriteCount: (json['favoriteCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'contact': instance.contact,
      'logoUrl': instance.logoUrl,
      'ownerId': instance.ownerId,
      'isApproved': instance.isApproved,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'city': instance.city,
      'district': instance.district,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'menu1': instance.menu1,
      'menu2': instance.menu2,
      'menu3': instance.menu3,
      'favoriteCount': instance.favoriteCount,
    };

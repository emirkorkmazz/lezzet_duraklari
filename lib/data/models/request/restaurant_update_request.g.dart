// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantUpdateRequest _$RestaurantUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    RestaurantUpdateRequest(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      contact: json['contact'] as String?,
      logoBase64: json['logoBase64'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RestaurantUpdateRequestToJson(
        RestaurantUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'contact': instance.contact,
      'logoBase64': instance.logoBase64,
      'city': instance.city,
      'district': instance.district,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

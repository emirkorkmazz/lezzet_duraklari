// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_menu_photos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMenuPhotosResponse _$GetMenuPhotosResponseFromJson(
        Map<String, dynamic> json) =>
    GetMenuPhotosResponse(
      status: json['status'] as bool?,
      menus: json['menus'] == null
          ? null
          : Menus.fromJson(json['menus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMenuPhotosResponseToJson(
        GetMenuPhotosResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'menus': instance.menus,
    };

Menus _$MenusFromJson(Map<String, dynamic> json) => Menus(
      menu1: json['menu1'] as String?,
      menu2: json['menu2'] as String?,
      menu3: json['menu3'] as String?,
    );

Map<String, dynamic> _$MenusToJson(Menus instance) => <String, dynamic>{
      'menu1': instance.menu1,
      'menu2': instance.menu2,
      'menu3': instance.menu3,
    };

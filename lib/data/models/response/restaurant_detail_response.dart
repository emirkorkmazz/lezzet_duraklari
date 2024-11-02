import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_detail_response.g.dart';

@JsonSerializable()
class RestaurantDetailResponse with EquatableMixin {
  bool? status;
  Restaurant? restaurant;
  List<String>? photos;

  RestaurantDetailResponse({
    this.status,
    this.restaurant,
    this.photos,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailResponseToJson(this);

  @override
  List<Object?> get props => [status, restaurant, photos];

  RestaurantDetailResponse copyWith({
    bool? status,
    Restaurant? restaurant,
    List<String>? photos,
  }) {
    return RestaurantDetailResponse(
      status: status ?? this.status,
      restaurant: restaurant ?? this.restaurant,
      photos: photos ?? this.photos,
    );
  }
}

@JsonSerializable()
class Restaurant with EquatableMixin {
  String? id;
  String? name;
  String? description;
  String? address;
  String? contact;
  String? logoUrl;
  String? ownerId;
  int? isApproved;
  String? createdAt;
  String? updatedAt;
  String? city;
  String? district;
  String? latitude;
  String? longitude;
  String? menu1;
  String? menu2;
  String? menu3;
  int? favoriteCount;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.address,
    this.contact,
    this.logoUrl,
    this.ownerId,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
    this.menu1,
    this.menu2,
    this.menu3,
    this.favoriteCount,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        address,
        contact,
        logoUrl,
        ownerId,
        isApproved,
        createdAt,
        updatedAt,
        city,
        district,
        latitude,
        longitude,
        menu1,
        menu2,
        menu3,
        favoriteCount
      ];

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    String? contact,
    String? logoUrl,
    String? ownerId,
    int? isApproved,
    String? createdAt,
    String? updatedAt,
    String? city,
    String? district,
    String? latitude,
    String? longitude,
    String? menu1,
    String? menu2,
    String? menu3,
    int? favoriteCount,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      logoUrl: logoUrl ?? this.logoUrl,
      ownerId: ownerId ?? this.ownerId,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      menu1: menu1 ?? this.menu1,
      menu2: menu2 ?? this.menu2,
      menu3: menu3 ?? this.menu3,
      favoriteCount: favoriteCount ?? this.favoriteCount,
    );
  }
}

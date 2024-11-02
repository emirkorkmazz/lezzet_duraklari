import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_update_request.g.dart';

@JsonSerializable()
class RestaurantUpdateRequest with EquatableMixin {
  String? id;
  String? name;
  String? description;
  String? address;
  String? contact;
  String? logoBase64;
  String? city;
  String? district;
  double? latitude;
  double? longitude;

  RestaurantUpdateRequest({
    this.id,
    this.name,
    this.description,
    this.address,
    this.contact,
    this.logoBase64,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
  });

  factory RestaurantUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$RestaurantUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantUpdateRequestToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        address,
        contact,
        logoBase64,
        city,
        district,
        latitude,
        longitude
      ];

  RestaurantUpdateRequest copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    String? contact,
    String? logoBase64,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
  }) {
    return RestaurantUpdateRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      logoBase64: logoBase64 ?? this.logoBase64,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

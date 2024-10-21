import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'add_restaurant_request.g.dart';

@JsonSerializable()
class AddRestaurantRequest with EquatableMixin {
  String? name;
  String? description;
  String? address;
  String? contact;
  String? menu;
  String? logoBase64;
  String? city;
  String? district;
  double? latitude;
  double? longitude;

  AddRestaurantRequest({
    this.name,
    this.description,
    this.address,
    this.contact,
    this.menu,
    this.logoBase64,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
  });

  factory AddRestaurantRequest.fromJson(Map<String, dynamic> json) =>
      _$AddRestaurantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddRestaurantRequestToJson(this);

  @override
  List<Object?> get props => [
        name,
        description,
        address,
        contact,
        menu,
        logoBase64,
        city,
        district,
        latitude,
        longitude
      ];

  AddRestaurantRequest copyWith({
    String? name,
    String? description,
    String? address,
    String? contact,
    String? menu,
    String? logoBase64,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
  }) {
    return AddRestaurantRequest(
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      menu: menu ?? this.menu,
      logoBase64: logoBase64 ?? this.logoBase64,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

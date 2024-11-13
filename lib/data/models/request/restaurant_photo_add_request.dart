import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_photo_add_request.g.dart';

@JsonSerializable()
class RestaurantPhotoAddRequest with EquatableMixin {
  String? restaurantId;
  List<String>? photosBase64;

  RestaurantPhotoAddRequest({
    this.restaurantId,
    this.photosBase64,
  });

  factory RestaurantPhotoAddRequest.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPhotoAddRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantPhotoAddRequestToJson(this);

  @override
  List<Object?> get props => [restaurantId, photosBase64];

  RestaurantPhotoAddRequest copyWith({
    String? restaurantId,
    List<String>? photosBase64,
  }) {
    return RestaurantPhotoAddRequest(
      restaurantId: restaurantId ?? this.restaurantId,
      photosBase64: photosBase64 ?? this.photosBase64,
    );
  }
}

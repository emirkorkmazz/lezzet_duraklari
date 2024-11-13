import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_photo_list_request.g.dart';

@JsonSerializable()
class RestaurantPhotoListRequest with EquatableMixin {
  String? restaurantId;

  RestaurantPhotoListRequest({
    this.restaurantId,
  });

  factory RestaurantPhotoListRequest.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPhotoListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantPhotoListRequestToJson(this);

  @override
  List<Object?> get props => [restaurantId];

  RestaurantPhotoListRequest copyWith({
    String? restaurantId,
  }) {
    return RestaurantPhotoListRequest(
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }
}

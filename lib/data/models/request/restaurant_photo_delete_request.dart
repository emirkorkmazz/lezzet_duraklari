import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_photo_delete_request.g.dart';

@JsonSerializable()
class RestaurantPhotoDeleteRequest with EquatableMixin {
  String? id;

  RestaurantPhotoDeleteRequest({
    this.id,
  });

  factory RestaurantPhotoDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPhotoDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantPhotoDeleteRequestToJson(this);

  @override
  List<Object?> get props => [id];

  RestaurantPhotoDeleteRequest copyWith({
    String? id,
  }) {
    return RestaurantPhotoDeleteRequest(
      id: id ?? this.id,
    );
  }
}

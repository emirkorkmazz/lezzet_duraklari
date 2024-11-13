import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_photo_delete_response.g.dart';

@JsonSerializable()
class RestaurantPhotoDeleteResponse with EquatableMixin {
  bool? status;
  String? message;

  RestaurantPhotoDeleteResponse({
    this.status,
    this.message,
  });

  factory RestaurantPhotoDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPhotoDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantPhotoDeleteResponseToJson(this);

  @override
  List<Object?> get props => [status, message];

  RestaurantPhotoDeleteResponse copyWith({
    bool? status,
    String? message,
  }) {
    return RestaurantPhotoDeleteResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

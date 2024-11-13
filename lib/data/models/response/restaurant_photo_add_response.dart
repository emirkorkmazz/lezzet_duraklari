import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_photo_add_response.g.dart';

@JsonSerializable()
class RestaurantPhotoAddResponse with EquatableMixin {
  bool? status;
  String? message;
  List<String>? photoUrls;

  RestaurantPhotoAddResponse({
    this.status,
    this.message,
    this.photoUrls,
  });

  factory RestaurantPhotoAddResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPhotoAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantPhotoAddResponseToJson(this);

  @override
  List<Object?> get props => [status, message, photoUrls];

  RestaurantPhotoAddResponse copyWith({
    bool? status,
    String? message,
    List<String>? photoUrls,
  }) {
    return RestaurantPhotoAddResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      photoUrls: photoUrls ?? this.photoUrls,
    );
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_photo_list_response.g.dart';

@JsonSerializable()
class RestaurantPhotoListResponse with EquatableMixin {
  final bool? status;
  final List<Photos>? photos;

  RestaurantPhotoListResponse({
    required this.status,
    required this.photos,
  });

  factory RestaurantPhotoListResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPhotoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantPhotoListResponseToJson(this);

  @override
  List<Object?> get props => [status, photos];

  RestaurantPhotoListResponse copyWith({
    bool? status,
    List<Photos>? photos,
  }) {
    return RestaurantPhotoListResponse(
      status: status ?? this.status,
      photos: photos ?? this.photos,
    );
  }
}

@JsonSerializable()
class Photos with EquatableMixin {
  final String? id;
  final String? photoUrl;
  final String? createdAt;

  Photos({
    required this.id,
    required this.photoUrl,
    required this.createdAt,
  });

  factory Photos.fromJson(Map<String, dynamic> json) => _$PhotosFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosToJson(this);

  @override
  List<Object?> get props => [id, photoUrl, createdAt];

  Photos copyWith({
    String? id,
    String? photoUrl,
    String? createdAt,
  }) {
    return Photos(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

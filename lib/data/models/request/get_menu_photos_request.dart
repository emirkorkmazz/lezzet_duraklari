import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'get_menu_photos_request.g.dart';

@JsonSerializable()
class GetMenuPhotosRequest with EquatableMixin {
  String? restaurantId;

  GetMenuPhotosRequest({
    this.restaurantId,
  });

  factory GetMenuPhotosRequest.fromJson(Map<String, dynamic> json) =>
      _$GetMenuPhotosRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetMenuPhotosRequestToJson(this);

  @override
  List<Object?> get props => [restaurantId];

  GetMenuPhotosRequest copyWith({
    String? restaurantId,
  }) {
    return GetMenuPhotosRequest(
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }
}

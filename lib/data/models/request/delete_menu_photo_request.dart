import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'delete_menu_photo_request.g.dart';

@JsonSerializable()
class DeleteMenuPhotoRequest with EquatableMixin {
  String? restaurantId;
  String? menuNumber;

  DeleteMenuPhotoRequest({
    this.restaurantId,
    this.menuNumber,
  });

  factory DeleteMenuPhotoRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteMenuPhotoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteMenuPhotoRequestToJson(this);

  @override
  List<Object?> get props => [restaurantId, menuNumber];

  DeleteMenuPhotoRequest copyWith({
    String? restaurantId,
    String? menuNumber,
  }) {
    return DeleteMenuPhotoRequest(
      restaurantId: restaurantId ?? this.restaurantId,
      menuNumber: menuNumber ?? this.menuNumber,
    );
  }
}

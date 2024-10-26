import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'add_menu_photos_request.g.dart';

@JsonSerializable()
class AddMenuPhotosRequest with EquatableMixin {
  String? restaurantId;
  String? menu1;
  String? menu2;
  String? menu3;

  AddMenuPhotosRequest({
    this.restaurantId,
    this.menu1,
    this.menu2,
    this.menu3,
  });

  factory AddMenuPhotosRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMenuPhotosRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddMenuPhotosRequestToJson(this);

  @override
  List<Object?> get props => [restaurantId, menu1, menu2, menu3];

  AddMenuPhotosRequest copyWith({
    String? restaurantId,
    String? menu1,
    String? menu2,
    String? menu3,
  }) {
    return AddMenuPhotosRequest(
      restaurantId: restaurantId ?? this.restaurantId,
      menu1: menu1 ?? this.menu1,
      menu2: menu2 ?? this.menu2,
      menu3: menu3 ?? this.menu3,
    );
  }
}

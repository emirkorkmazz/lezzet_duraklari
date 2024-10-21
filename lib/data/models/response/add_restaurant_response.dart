import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'add_restaurant_response.g.dart';

@JsonSerializable()
class AddRestaurantResponse with EquatableMixin {
  bool? status;
  String? message;
  String? restaurantId;

  AddRestaurantResponse({
    this.status,
    this.message,
    this.restaurantId,
  });

  factory AddRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$AddRestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddRestaurantResponseToJson(this);

  @override
  List<Object?> get props => [status, message, restaurantId];

  AddRestaurantResponse copyWith({
    bool? status,
    String? message,
    String? restaurantId,
  }) {
    return AddRestaurantResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }
}

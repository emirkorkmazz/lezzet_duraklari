import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_update_response.g.dart';

@JsonSerializable()
class RestaurantUpdateResponse with EquatableMixin {
  bool? status;
  String? message;

  RestaurantUpdateResponse({
    this.status,
    this.message,
  });

  factory RestaurantUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantUpdateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantUpdateResponseToJson(this);

  @override
  List<Object?> get props => [status, message];

  RestaurantUpdateResponse copyWith({
    bool? status,
    String? message,
  }) {
    return RestaurantUpdateResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

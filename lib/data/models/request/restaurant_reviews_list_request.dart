import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_reviews_list_request.g.dart';

@JsonSerializable()
class RestaurantReviewsListRequest with EquatableMixin {
  String? restaurantId;
  int? page;
  int? pageSize;

  RestaurantReviewsListRequest({
    this.restaurantId,
    this.page,
    this.pageSize,
  });

  factory RestaurantReviewsListRequest.fromJson(Map<String, dynamic> json) =>
      _$RestaurantReviewsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantReviewsListRequestToJson(this);

  @override
  List<Object?> get props => [restaurantId, page, pageSize];

  RestaurantReviewsListRequest copyWith({
    String? restaurantId,
    int? page,
    int? pageSize,
  }) {
    return RestaurantReviewsListRequest(
      restaurantId: restaurantId ?? this.restaurantId,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

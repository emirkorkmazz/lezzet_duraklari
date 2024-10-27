// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_reviews_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantReviewsListRequest _$RestaurantReviewsListRequestFromJson(
        Map<String, dynamic> json) =>
    RestaurantReviewsListRequest(
      restaurantId: json['restaurantId'] as String?,
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RestaurantReviewsListRequestToJson(
        RestaurantReviewsListRequest instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_reviews_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantReviewsListResponse _$RestaurantReviewsListResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantReviewsListResponse(
      status: json['status'] as bool?,
      totalCount: (json['totalCount'] as num?)?.toInt(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantReviewsListResponseToJson(
        RestaurantReviewsListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalCount': instance.totalCount,
      'reviews': instance.reviews,
    };

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      id: json['id'] as String?,
      restaurantId: json['restaurantId'] as String?,
      userId: json['userId'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      userName: json['userName'] as String?,
      userSurname: json['userSurname'] as String?,
      isReviewReply: Reviews._boolFromDynamic(json['isReviewReply']),
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'userId': instance.userId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'userName': instance.userName,
      'userSurname': instance.userSurname,
      'isReviewReply': instance.isReviewReply,
    };

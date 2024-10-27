import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'restaurant_reviews_list_response.g.dart';

@JsonSerializable()
class RestaurantReviewsListResponse with EquatableMixin {
  bool? status;
  int? totalCount;
  List<Reviews>? reviews;

  RestaurantReviewsListResponse({
    this.status,
    this.totalCount,
    this.reviews,
  });

  factory RestaurantReviewsListResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantReviewsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantReviewsListResponseToJson(this);

  @override
  List<Object?> get props => [status, totalCount, reviews];

  RestaurantReviewsListResponse copyWith({
    bool? status,
    int? totalCount,
    List<Reviews>? reviews,
  }) {
    return RestaurantReviewsListResponse(
      status: status ?? this.status,
      totalCount: totalCount ?? this.totalCount,
      reviews: reviews ?? this.reviews,
    );
  }
}

@JsonSerializable()
class Reviews with EquatableMixin {
  String? id;
  String? restaurantId;
  String? userId;
  int? rating;
  String? comment;
  String? createdAt;
  String? userName;
  String? userSurname;
  @JsonKey(fromJson: _boolFromDynamic)
  bool? isReviewReply;
  Reviews({
    this.id,
    this.restaurantId,
    this.userId,
    this.rating,
    this.comment,
    this.createdAt,
    this.userName,
    this.userSurname,
    this.isReviewReply,
  });

  static bool? _boolFromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    if (value is int) return value == 1;
    return false;
  }

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        userId,
        rating,
        comment,
        createdAt,
        userName,
        userSurname,
        isReviewReply,
      ];

  Reviews copyWith({
    String? id,
    String? restaurantId,
    String? userId,
    int? rating,
    String? comment,
    String? createdAt,
    String? userName,
    String? userSurname,
    bool? isReviewReply,
  }) {
    return Reviews(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      userName: userName ?? this.userName,
      userSurname: userSurname ?? this.userSurname,
      isReviewReply: isReviewReply ?? this.isReviewReply,
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_reply_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewReplyRequest _$ReviewReplyRequestFromJson(Map<String, dynamic> json) =>
    ReviewReplyRequest(
      reviewId: json['reviewId'] as String?,
      reply: json['reply'] as String?,
    );

Map<String, dynamic> _$ReviewReplyRequestToJson(ReviewReplyRequest instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'reply': instance.reply,
    };

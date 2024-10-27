// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_reply_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewReplyResponse _$ReviewReplyResponseFromJson(Map<String, dynamic> json) =>
    ReviewReplyResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ReviewReplyResponseToJson(
        ReviewReplyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

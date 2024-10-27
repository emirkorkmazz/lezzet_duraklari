import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'review_reply_request.g.dart';

@JsonSerializable()
class ReviewReplyRequest with EquatableMixin {
  const ReviewReplyRequest({
    required this.reviewId,
    required this.reply,
  });

  factory ReviewReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewReplyRequestFromJson(json);

  final String? reviewId;
  final String? reply;

  Map<String, dynamic> toJson() => _$ReviewReplyRequestToJson(this);

  @override
  List<Object?> get props => [reviewId, reply];

  ReviewReplyRequest copyWith({
    String? reviewId,
    String? reply,
  }) {
    return ReviewReplyRequest(
      reviewId: reviewId ?? this.reviewId,
      reply: reply ?? this.reply,
    );
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'review_reply_response.g.dart';

@JsonSerializable()
class ReviewReplyResponse with EquatableMixin {
  const ReviewReplyResponse({
    required this.status,
    required this.message,
  });

  factory ReviewReplyResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewReplyResponseFromJson(json);

  final bool? status;
  final String? message;

  Map<String, dynamic> toJson() => _$ReviewReplyResponseToJson(this);

  @override
  List<Object?> get props => [status, message];

  ReviewReplyResponse copyWith({
    bool? status,
    String? message,
  }) {
    return ReviewReplyResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

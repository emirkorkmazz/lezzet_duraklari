part of 'review_reply_bloc.dart';

enum ReviewReplyStatus {
  unknown,
  loading,
  failure,
  edit,
  success,
}

final class ReviewReplyState extends Equatable {
  const ReviewReplyState({
    this.reply = const NameInput.pure(),
    this.isValid = false,
    this.status = ReviewReplyStatus.unknown,
  });

  final NameInput reply;
  final bool isValid;
  final ReviewReplyStatus status;

  ReviewReplyState copyWith({
    NameInput? reply,
    bool? isValid,
    ReviewReplyStatus? status,
  }) {
    return ReviewReplyState(
      reply: reply ?? this.reply,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        reply,
        isValid,
        status,
      ];
}

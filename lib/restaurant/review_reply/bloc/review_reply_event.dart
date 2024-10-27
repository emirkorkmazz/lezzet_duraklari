part of 'review_reply_bloc.dart';

sealed class ReviewReplyEvent extends Equatable {
  const ReviewReplyEvent();
  @override
  List<Object> get props => [];
}

final class ReviewReplyReplyChanged extends ReviewReplyEvent {
  const ReviewReplyReplyChanged(this.reply);
  final String reply;
  @override
  List<Object> get props => [reply];
}

final class ReviewReplySubmitted extends ReviewReplyEvent {
  const ReviewReplySubmitted(
    this.reviewId,
    this.reply,
  );
  final String reviewId;
  final String reply;
  @override
  List<Object> get props => [reviewId, reply];
}

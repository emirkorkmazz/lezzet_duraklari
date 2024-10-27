import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

part 'review_reply_event.dart';
part 'review_reply_state.dart';

@Injectable()
class ReviewReplyBloc extends Bloc<ReviewReplyEvent, ReviewReplyState> {
  ReviewReplyBloc({
    required this.restaurantRepository,
  }) : super(const ReviewReplyState()) {
    ///
    on<ReviewReplyReplyChanged>(_onReplyChanged);

    ///
    on<ReviewReplySubmitted>(_onSubmitted);
  }
  final IRestaurantRepository restaurantRepository;

  /// [1 Reply] alanı doldurulduğunda kontrol
  FutureOr<void> _onReplyChanged(
    ReviewReplyReplyChanged event,
    Emitter<ReviewReplyState> emit,
  ) {
    ///
    final reply = NameInput.dirty(event.reply);
    emit(
      state.copyWith(
        reply: reply,
        status: ReviewReplyStatus.edit,
        isValid: Formz.validate([reply]),
      ),
    );
  }

  /// [2 Submit] butonuna basıldığında kontrol
  FutureOr<void> _onSubmitted(
    ReviewReplySubmitted event,
    Emitter<ReviewReplyState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: ReviewReplyStatus.loading));

    /// Request'i hazırlayalım
    final request = ReviewReplyRequest(
      reply: state.reply.value,
      reviewId: event.reviewId,
    );

    /// Metodu çağır
    final result = await restaurantRepository.reviewReply(request: request);

    ///
    result.fold(
      /// [Handle left]: Error Type
      (AuthFailure failure) => emit(
        state.copyWith(
          status: ReviewReplyStatus.failure,
        ),
      ),

      /// [Handle right]: Response Type
      (response) {
        return emit(
          state.copyWith(
            status: ReviewReplyStatus.success,
          ),
        );
      },
    );
  }
}

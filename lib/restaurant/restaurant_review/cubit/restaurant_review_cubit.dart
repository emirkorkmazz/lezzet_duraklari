import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

part 'restaurant_review_state.dart';

@Injectable()
class RestaurantReviewCubit extends Cubit<RestaurantReviewState> {
  RestaurantReviewCubit({
    required this.restaurantRepository,
    required this.storageRepository,
  }) : super(const RestaurantReviewState());

  final IRestaurantRepository restaurantRepository;
  final IStorageRepository storageRepository;
  static const _pageSize = 10;

  Future<void> fetchReviews() async {
    emit(state.copyWith(
      status: RestaurantReviewStatus.loading,
      message: null,
    ));

    try {
      final restaurantId = await storageRepository.getRestaurantId();
      final result = await restaurantRepository.restaurantReviewsList(
        request: RestaurantReviewsListRequest(
          restaurantId: restaurantId,
          page: 1,
          pageSize: _pageSize,
        ),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          status: RestaurantReviewStatus.failure,
          message: failure.message,
        )),
        (response) {
          final totalCount = response.totalCount ?? 0;
          final hasReachedEnd = (state.currentPage * _pageSize) >= totalCount;

          emit(state.copyWith(
            status: RestaurantReviewStatus.success,
            reviews: response.reviews ?? [],
            hasReachedEnd: hasReachedEnd,
            currentPage: 1,
            totalCount: totalCount,
            message: null,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: RestaurantReviewStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> loadMoreReviews() async {
    if (state.hasReachedEnd ||
        state.status == RestaurantReviewStatus.loadingMore) return;

    emit(state.copyWith(
      status: RestaurantReviewStatus.loadingMore,
      message: null,
    ));

    final restaurantId = await storageRepository.getRestaurantId();
    final result = await restaurantRepository.restaurantReviewsList(
      request: RestaurantReviewsListRequest(
        restaurantId: restaurantId,
        page: state.currentPage + 1,
        pageSize: _pageSize,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: RestaurantReviewStatus.failure,
      )),
      (response) {
        final reviews = response.reviews ?? [];
        final newReviews = List<Reviews>.from([...state.reviews, ...reviews]);
        final totalCount = response.totalCount ?? 0;
        final hasReachedEnd = (newReviews.length >= totalCount);

        emit(state.copyWith(
          status: RestaurantReviewStatus.success,
          reviews: newReviews,
          currentPage: state.currentPage + 1,
          hasReachedEnd: hasReachedEnd,
          totalCount: totalCount,
          message: null,
        ));
      },
    );
  }
}

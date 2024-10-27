part of 'restaurant_review_cubit.dart';

enum RestaurantReviewStatus {
  initial, // başlangıç durumu
  loading, // veri yüklenirken
  success, // veriler başarıyla yüklendiğinde
  failure, // hata durumunda
  loadingMore, // daha fazla yükleme işlemi sırasında
}

final class RestaurantReviewState extends Equatable {
  const RestaurantReviewState({
    this.status = RestaurantReviewStatus.loading,
    this.message,
    this.reviews = const [],
    this.currentPage = 1,
    this.hasReachedEnd = false,
    this.totalCount = 0,
  });

  final RestaurantReviewStatus status;
  final String? message;
  final List<Reviews> reviews;
  final int currentPage;
  final bool hasReachedEnd;
  final int totalCount;

  RestaurantReviewState copyWith({
    RestaurantReviewStatus? status,
    List<Reviews>? reviews,
    String? message,
    int? currentPage,
    bool? hasReachedEnd,
    int? totalCount,
  }) {
    return RestaurantReviewState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [
        status,
        reviews,
        message,
        currentPage,
        hasReachedEnd,
        totalCount,
      ];
}

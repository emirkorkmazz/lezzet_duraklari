import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/response/restaurant_reviews_list_response.dart';
import '/core/core.dart';
import '../cubit/restaurant_review_cubit.dart';

class RestaurantReviewView extends StatefulWidget {
  const RestaurantReviewView({super.key});

  @override
  State<RestaurantReviewView> createState() => _RestaurantReviewViewState();
}

class _RestaurantReviewViewState extends State<RestaurantReviewView> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantReviewCubit>().fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: _RestaurantReviewBody(),
    );
  }
}

class _RestaurantReviewBody extends StatelessWidget {
  const _RestaurantReviewBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantReviewCubit, RestaurantReviewState>(
      builder: (context, state) {
        return switch (state.status) {
          RestaurantReviewStatus.initial ||
          RestaurantReviewStatus.loading =>
            const Center(
              child: CircularProgressIndicator(),
            ),
          RestaurantReviewStatus.failure => Center(
              child:
                  Text(state.message ?? 'Yorumlar yüklenirken bir hata oluştu'),
            ),
          RestaurantReviewStatus.success ||
          RestaurantReviewStatus.loadingMore =>
            state.reviews.isEmpty
                ? const Center(child: Text('Henüz yorum yapılmamış'))
                : NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          notification.metrics.extentAfter == 0) {
                        context.read<RestaurantReviewCubit>().loadMoreReviews();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount:
                          state.reviews.length + (state.hasReachedEnd ? 0 : 1),
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        if (index == state.reviews.length) {
                          return state.status ==
                                  RestaurantReviewStatus.loadingMore
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox();
                        }

                        final review = state.reviews[index];
                        return _ReviewCard(review: review);
                      },
                    ),
                  ),
        };
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final Reviews review;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${review.userName} ${review.userSurname ?? ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    review.rating ?? 0,
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.comment ?? ''),
            const SizedBox(height: 8),
            Text(
              review.createdAt ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            /// Eğerki restorant sahibi yorumu cevaplamamışsa cevapla butonu göster
            if (!(review.isReviewReply ?? false))
              TextButton(
                onPressed: () {
                  context.push(
                    AppRouteName.reviewReply.path,
                    extra: {
                      'reviewId': review.id,
                      'comment': review.comment,
                    },
                  );
                },
                child: const Text('Cevapla'),
              ),
          ],
        ),
      ),
    );
  }
}

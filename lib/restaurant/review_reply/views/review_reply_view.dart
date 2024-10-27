import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../bloc/bloc.dart';

class ReviewReplyView extends StatefulWidget {
  const ReviewReplyView({
    super.key,
    required this.reviewId,
    required this.comment,
  });
  final String reviewId;
  final String comment;

  @override
  State<ReviewReplyView> createState() => _ReviewReplyViewState();
}

class _ReviewReplyViewState extends State<ReviewReplyView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReviewReplyBloc>(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: _ReviewReplyBody(
          reviewId: widget.reviewId,
          comment: widget.comment,
        ),
      ),
    );
  }
}

class _ReviewReplyBody extends StatelessWidget {
  const _ReviewReplyBody({
    super.key,
    required this.reviewId,
    required this.comment,
  });
  final String reviewId;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewReplyBloc, ReviewReplyState>(
      listener: (context, state) {
        if (state.status == ReviewReplyStatus.success) {
          context.pop();
        } else if (state.status == ReviewReplyStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bir hata oluştu')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Yorum:',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Text(comment),
            const SizedBox(height: 16),
            _ReviewReplyForm(reviewId: reviewId, comment: comment),
            const SizedBox(height: 16),
            _SubmitButton(reviewId: reviewId),
          ],
        ),
      ),
    );
  }
}

class _ReviewReplyForm extends StatelessWidget {
  const _ReviewReplyForm({
    super.key,
    required this.reviewId,
    required this.comment,
  });
  final String reviewId;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewReplyBloc, ReviewReplyState>(
      buildWhen: (previous, current) => previous.reply != current.reply,
      builder: (context, state) {
        return FocusScope(
          child: AppTextField(
            hintText: 'Cevap yazınız...',
            maxLines: 5,
            onChanged: (reply) {
              context
                  .read<ReviewReplyBloc>()
                  .add(ReviewReplyReplyChanged(reply));
            },
            errorText:
                state.reply.displayError != null ? 'Geçersiz cevap' : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.reviewId});
  final String reviewId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewReplyBloc, ReviewReplyState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        return state.status == ReviewReplyStatus.loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.isValid
                    ? () {
                        context.read<ReviewReplyBloc>().add(
                              ReviewReplySubmitted(reviewId, state.reply.value),
                            );
                      }
                    : null,
                child: const Text('Cevabı Gönder'),
              );
      },
    );
  }
}

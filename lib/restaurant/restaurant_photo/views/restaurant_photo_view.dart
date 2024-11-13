import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/core.dart';
import '/restaurant/restaurant.dart';
import '/data/data.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class RestaurantPhotoView extends StatefulWidget {
  const RestaurantPhotoView({super.key});

  @override
  State<RestaurantPhotoView> createState() => _RestaurantPhotoViewState();
}

class _RestaurantPhotoViewState extends State<RestaurantPhotoView> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantPhotoCubit>().fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: _RestaurantPhotoViewBody(),
    );
  }
}

class _RestaurantPhotoViewBody extends StatelessWidget {
  const _RestaurantPhotoViewBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantPhotoCubit, RestaurantPhotoState>(
      listener: (context, state) {
        if (state.status == RestaurantPhotoStatus.submitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fotoğraflar başarıyla kaydedildi'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case RestaurantPhotoStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case RestaurantPhotoStatus.failure:
            return const Center(
              child: Text('Fotoğraflar yüklenirken bir hata oluştu'),
            );

          case RestaurantPhotoStatus.success:
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Expanded(child: PhotoGridView()),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.status ==
                              RestaurantPhotoStatus.submitting
                          ? null
                          : () {
                              context.read<RestaurantPhotoCubit>().savePhotos();
                            },
                      child: state.status == RestaurantPhotoStatus.submitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Kaydet'),
                    ),
                  ),
                ],
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class PhotoGridView extends StatelessWidget {
  const PhotoGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantPhotoCubit, RestaurantPhotoState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.7,
          ),
          itemCount: 3, // Sabit 3 grid
          itemBuilder: (context, index) {
            if (index < state.photos.length) {
              return PhotoCard(photo: state.photos[index]);
            }
            return EmptyPhotoCard(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 50,
                );

                if (image != null) {
                  final bytes = await image.readAsBytes();
                  final base64String = base64Encode(bytes);

                  if (context.mounted) {
                    context.read<RestaurantPhotoCubit>().addPhoto(base64String);
                  }
                }
              },
            );
          },
        );
      },
    );
  }
}

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    super.key,
    required this.photo,
  });

  final Photos photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              '${EnvConf.baseUrl}/${photo.photoUrl}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error),
                );
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (photo.id != null) {
                    context
                        .read<RestaurantPhotoCubit>()
                        .deletePhoto(id: photo.id!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyPhotoCard extends StatelessWidget {
  const EmptyPhotoCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        child: const Center(
          child: Icon(
            Icons.add_photo_alternate_outlined,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

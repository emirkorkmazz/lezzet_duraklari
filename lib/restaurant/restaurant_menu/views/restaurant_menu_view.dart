import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '/data/data.dart';
import '/domain/domain.dart';
import '/core/core.dart';
import '/restaurant/restaurant.dart';

class RestaurantMenuView extends StatefulWidget {
  const RestaurantMenuView({super.key});

  @override
  State<RestaurantMenuView> createState() => _RestaurantMenuViewState();
}

class _RestaurantMenuViewState extends State<RestaurantMenuView> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int photoIndex) async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (selectedImage != null) {
      final bytes = await selectedImage.readAsBytes();
      final base64Image = base64Encode(bytes);

      switch (photoIndex) {
        case 1:
          context
              .read<RestaurantMenuCubit>()
              .updatePhoto1(PhotoInput.dirty(base64Image));
          break;
        case 2:
          context
              .read<RestaurantMenuCubit>()
              .updatePhoto2(PhotoInput.dirty(base64Image));
          break;
        case 3:
          context
              .read<RestaurantMenuCubit>()
              .updatePhoto3(PhotoInput.dirty(base64Image));
          break;
      }
    }
  }

  Future<void> _deleteImage(String menuNumber) async {
    final restaurantId = await context
        .read<RestaurantMenuCubit>()
        .storageRepository
        .getRestaurantId();
    await context
        .read<RestaurantMenuCubit>()
        .deleteMenuPhotos(menuNumber: menuNumber);

    if (mounted) {
      context.read<RestaurantMenuCubit>().fetchMenuPhotos();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<RestaurantMenuCubit>().fetchMenuPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RestaurantMenuCubit, RestaurantMenuState>(
            listenWhen: (previous, current) =>
                previous.message != current.message && current.message != null,
            listener: (context, state) {
              if (state.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                    backgroundColor:
                        state.status == RestaurantMenuStatus.failure
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.primary,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<RestaurantMenuCubit, RestaurantMenuState>(
          builder: (context, state) {
            return switch (state.status) {
              RestaurantMenuStatus.initial ||
              RestaurantMenuStatus.loading =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
              RestaurantMenuStatus.failure => const Center(
                  child: Text('Resimler yüklenirken bir hata oluştu.'),
                ),
              RestaurantMenuStatus.submitting => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Fotoğraflar kaydediliyor...'),
                    ],
                  ),
                ),
              RestaurantMenuStatus.deleting => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Fotoğraf siliniyor...'),
                    ],
                  ),
                ),
              _ => Column(
                  children: [
                    Expanded(
                      child: _RestaurantMenuBody(
                        menuPhotos: state.menus,
                        photo1: state.photo1,
                        photo2: state.photo2,
                        photo3: state.photo3,
                        onPickImage: _pickImage,
                        onDeleteImage: _deleteImage,
                      ),
                    ),
                    const _SubmitButton(),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}

class _RestaurantMenuBody extends StatelessWidget {
  final Menus? menuPhotos;
  final PhotoInput photo1;
  final PhotoInput photo2;
  final PhotoInput photo3;
  final Function(int) onPickImage;
  final Function(String) onDeleteImage;

  const _RestaurantMenuBody({
    required this.menuPhotos,
    required this.photo1,
    required this.photo2,
    required this.photo3,
    required this.onPickImage,
    required this.onDeleteImage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildMenuItem(
          context,
          menuPhotos?.menu1,
          photo1.value,
          "menu1",
          1,
          "1. Menü Fotoğrafı",
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          context,
          menuPhotos?.menu2,
          photo2.value,
          "menu2",
          2,
          "2. Menü Fotoğrafı",
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          context,
          menuPhotos?.menu3,
          photo3.value,
          "menu3",
          3,
          "3. Menü Fotoğrafı",
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String? menu,
    String? base64Image,
    String menuNumber,
    int photoIndex,
    String labelText,
  ) {
    // Resim var mı kontrolü
    final hasImage =
        menu != null || (base64Image != null && base64Image.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            if (!hasImage) {
              onPickImage(photoIndex);
            }
          },
          child: base64Image != null && base64Image.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.memory(
                    base64Decode(base64Image.split(',').last),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : menu != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.network(
                        '${EnvConf.baseUrl}$menu?${DateTime.now().millisecondsSinceEpoch}',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Column(
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              Text("Resim yüklenemedi"),
                            ],
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                onPickImage(photoIndex);
                              },
                              child: const Text(
                                "Fotoğraf seç",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
        ),
        if (hasImage)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _CustomDeleteDialog(
                      menuNumber: menuNumber,
                      onDeleteImage: onDeleteImage,
                    ),
                  );
                },
                child: const Text("Sil", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantMenuCubit>().state;
    final read = context.read<RestaurantMenuCubit>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppElevatedButton(
        onPressed: state.status == RestaurantMenuStatus.submitting
            ? null
            : () {
                FocusScope.of(context).unfocus();
                read.submitMenuPhotos();
              },
        child: state.status == RestaurantMenuStatus.submitting
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : const Text('Kaydet'),
      ),
    );
  }
}

class _CustomDeleteDialog extends StatelessWidget {
  final String menuNumber;
  final Function(String) onDeleteImage;

  const _CustomDeleteDialog({
    required this.menuNumber,
    required this.onDeleteImage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Resim silinsin mi?'),
      content: const Text('Bu resmi silmek istediğinizden emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Hayır'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDeleteImage(menuNumber);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Evet'),
        ),
      ],
    );
  }
}

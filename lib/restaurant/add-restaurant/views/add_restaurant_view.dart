import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '/restaurant/add-restaurant/bloc/add_restaurant_bloc.dart';

class AddRestaurantView extends StatelessWidget {
  const AddRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Klavyeyi kapatmak için
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: _AddRestaurantViewBody(),
      ),
    );
  }
}

class _AddRestaurantViewBody extends StatelessWidget {
  const _AddRestaurantViewBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: const [
        /// [1] Logo Ekleme Alanı
        _AddImageRow(),
        SizedBox(height: 40),

        /// [2] Restoran Adı Girişi
        _RestaurantNameInput(),
        SizedBox(height: 2),

        /// [3] Restoran Açıklaması Girişi
        _RestaurantDescriptionInput(),
        SizedBox(height: 2),

        /// [4] Restoran Adresi Girişi
        _RestaurantAddressInput(),
        SizedBox(height: 2),

        /// [4] Restoran Telefonu Girişi
        _RestaurantContactInput(),
        SizedBox(height: 2),

        /// [5] Restoran Şehri Girişi
        _RestaurantCityInput(),
        SizedBox(height: 2),

        /// [6] Restoran İlçesi Girişi
        _RestaurantDistrictInput(),
        SizedBox(height: 2),

        /// [7] Restoran Menü Bilgisi Girişi
        _RestaurantMenuInput(),
        SizedBox(height: 2),

        /// [8] Kaydet Butonu
        _SubmitButton(),
      ],
    );
  }
}

class _AddImageRow extends StatefulWidget {
  const _AddImageRow({super.key});

  @override
  State<_AddImageRow> createState() => _AddImageRowState();
}

class _AddImageRowState extends State<_AddImageRow> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? _base64Image;

  Future<void> _pickImage() async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (selectedImage != null) {
      final bytes = await selectedImage.readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _imageFile = selectedImage;
        _base64Image = base64Image;
      });

      context
          .read<AddRestaurantBloc>()
          .add(AddRestaurantLogoChanged(base64Image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_imageFile == null)
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Fotoğraf Seç'),
          ),
        const SizedBox(height: 20),
        _imageFile != null
            ? Image.file(
                File(_imageFile!.path),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              )
            : const Center(child: Text('Henüz fotoğraf seçilmedi.')),
      ],
    );
  }
}

class _RestaurantNameInput extends StatelessWidget {
  const _RestaurantNameInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();
    final state = context.watch<AddRestaurantBloc>().state;

    return AppTextField(
      hintText: 'Restoran Adı',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.restaurant),
      onChanged: (name) => read.add(AddRestaurantNameChanged(name)),
      errorText: state.name.displayError?.errorText(context, 'Restoran Adı'),
    );
  }
}

class _RestaurantDescriptionInput extends StatelessWidget {
  const _RestaurantDescriptionInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();
    final state = context.watch<AddRestaurantBloc>().state;

    return AppTextField(
      hintText: 'Restoran Açıklaması',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.description),
      onChanged: (description) =>
          read.add(AddRestaurantDescriptionChanged(description)),
      errorText: state.description.displayError?.errorText(context, 'Açıklama'),
    );
  }
}

class _RestaurantAddressInput extends StatelessWidget {
  const _RestaurantAddressInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();
    final state = context.watch<AddRestaurantBloc>().state;

    return AppTextField(
      hintText: 'Restoran Adresi',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.location_on),
      onChanged: (address) => read.add(AddRestaurantAddressChanged(address)),
      errorText: state.address.displayError?.errorText(context, 'Adres'),
    );
  }
}

class _RestaurantContactInput extends StatelessWidget {
  const _RestaurantContactInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();
    final state = context.watch<AddRestaurantBloc>().state;

    return AppTextField(
      hintText: 'Restoran Telefonu',
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.phone),
      onChanged: (contact) => read.add(AddRestaurantContactChanged(contact)),
      errorText: state.contact.displayError?.errorText(context, 'Telefon'),
    );
  }
}

class _RestaurantCityInput extends StatelessWidget {
  const _RestaurantCityInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();
    final state = context.watch<AddRestaurantBloc>().state;

    return AppTextField(
      hintText: 'Restoran Şehri',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.location_city),
      onChanged: (city) => read.add(AddRestaurantCityChanged(city)),
      errorText: state.city.displayError?.errorText(context, 'Şehir'),
    );
  }
}

class _RestaurantDistrictInput extends StatelessWidget {
  const _RestaurantDistrictInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();
    final state = context.watch<AddRestaurantBloc>().state;

    return AppTextField(
      hintText: 'Restoran İlçesi',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.location_city),
      onChanged: (district) => read.add(AddRestaurantDistrictChanged(district)),
      errorText: state.district.displayError?.errorText(context, 'İlçe'),
    );
  }
}

class _RestaurantMenuInput extends StatelessWidget {
  const _RestaurantMenuInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();

    return AppTextField(
      hintText: 'Menü Bilgisi',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      prefix: const Icon(Icons.menu),
      onChanged: (menu) => read.add(AddRestaurantMenuChanged(menu)),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AddRestaurantBloc>();
    final state = context.watch<AddRestaurantBloc>().state;

    return BlocListener<AddRestaurantBloc, AddRestaurantState>(
      listener: (context, state) {
        if (state.status == AddRestaurantStatus.success) {
          final snackBar = SnackBar(
            content: Text(
              'Restoran başarıyla eklendi!',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          _goHomeView(context);
        } else if (state.status == AddRestaurantStatus.failure) {
          final snackBar = SnackBar(
            content: Text(
              'Restoran ekleme başarısız!',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      child: AppElevatedButton(
        onPressed: state.isValid
            ? () {
                FocusScope.of(context).unfocus();

                final base64Logo = state.logoBase64;

                read.add(
                  AddRestaurantSubmitted(
                    state.name.value,
                    state.description.value,
                    state.address.value,
                    state.contact.value,
                    state.city.value,
                    state.district.value,
                    state.menu.value,
                    state.latitude,
                    state.longitude,
                    base64Logo,
                  ),
                );
              }
            : null,
        child: state.status == AddRestaurantStatus.loading
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : const Text('Restoran Ekle'),
      ),
    );
  }

  void _goHomeView(BuildContext context) {
    context.go(AppRouteName.restaurantHome.path);
  }
}

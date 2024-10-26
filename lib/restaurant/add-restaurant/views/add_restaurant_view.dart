import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '/core/core.dart';
import '/restaurant/restaurant.dart';

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

        /// [3] Restoran Açıklaması Girişi
        _RestaurantDescriptionInput(),

        /// [4] Restoran Adresi Girişi
        _RestaurantAddressInput(),

        /// [4] Restoran Telefonu Girişi
        _RestaurantContactInput(),

        /// [5] Restoran Şehri Girişi
        _CityPicker(),
        SizedBox(height: 12),

        /// [6] Restoran İlçesi Girişi
        _DistrictPicker(),
        SizedBox(height: 12),
        _MapPicker(),
        SizedBox(height: 12),

        /// [8] Kaydet Butonu
        _SubmitButton(),
        SizedBox(height: 20),
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
            child: const Text('Logo Seç'),
          ),
        const SizedBox(height: 20),
        _imageFile != null
            ? Image.file(
                File(_imageFile!.path),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              )
            : const Center(child: Text('Henüz logo seçilmedi.')),
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

class _CityPicker extends StatelessWidget {
  const _CityPicker();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddRestaurantBloc>().state;
    final cities = turkeyCities.keys.toList().cast<String>()..sort();

    String? currentValue =
        state.city.value.isNotEmpty && cities.contains(state.city.value)
            ? state.city.value
            : null;

    return CustomDropdown(
      value: currentValue,
      items: cities,
      labelText: 'İl',
      onChanged: (String? newValue) {
        if (newValue != null) {
          context
              .read<AddRestaurantBloc>()
              .add(AddRestaurantCityChanged(newValue));
          context
              .read<AddRestaurantBloc>()
              .add(const AddRestaurantDistrictChanged(''));
        }
      },
    );
  }
}

class _DistrictPicker extends StatelessWidget {
  const _DistrictPicker();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddRestaurantBloc>().state;
    final districts = state.city.value.isNotEmpty
        ? turkeyCities[state.city.value]?.cast<String>() ??
            [] // Burada cast yapıldı
        : [];

    String? currentValue = state.district.value.isNotEmpty &&
            districts.contains(state.district.value)
        ? state.district.value
        : null;

    return CustomDropdown(
      value: currentValue,
      items: districts.cast<String>(),
      labelText: 'İlçe',
      onChanged: state.city.value.isNotEmpty
          ? (String? newValue) {
              if (newValue != null) {
                context
                    .read<AddRestaurantBloc>()
                    .add(AddRestaurantDistrictChanged(newValue));
              }
            }
          : null,
    );
  }
}

class _MapPicker extends StatefulWidget {
  const _MapPicker();

  @override
  State<_MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<_MapPicker> {
  LatLng? _currentLocation;
  LatLng? _selectedLocation;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Konum servisleri etkin değilse, kullanıcıya bir mesaj gösterin
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // İzinler reddedildiyse, kullanıcıya bir mesaj gösterin
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // İzinler kalıcı olarak reddedildiyse, kullanıcıya bir mesaj gösterin
      return;
    }

    // Buraya geldiysek, konum izni alınmış demektir
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController.move(_currentLocation!, 15);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? LatLng(41.0082, 28.9784),
              initialZoom: 15,
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedLocation = point;
                });
                context.read<AddRestaurantBloc>().add(
                      AddRestaurantLocationChanged(
                          point.latitude, point.longitude),
                    );
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              if (_currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation!,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _selectedLocation!,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
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

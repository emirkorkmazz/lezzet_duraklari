import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '/core/core.dart';
import '/domain/domain.dart';
import '/restaurant/restaurant.dart';

class RestaurantUpdateView extends StatefulWidget {
  const RestaurantUpdateView({super.key});

  @override
  State<RestaurantUpdateView> createState() => _RestaurantUpdateViewState();
}

class _RestaurantUpdateViewState extends State<RestaurantUpdateView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadRestaurantDetails());
  }

  Future<void> _loadRestaurantDetails() async {
    final storageRepository = getIt<IStorageRepository>();
    final restaurantId = await storageRepository.getRestaurantId();

    if (restaurantId != null && mounted) {
      context
          .read<RestaurantUpdateBloc>()
          .add(RestaurantDetailRequested(restaurantId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantUpdateBloc, RestaurantUpdateState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleBlocState,
      child: BlocBuilder<RestaurantUpdateBloc, RestaurantUpdateState>(
        builder: (context, state) {
          switch (state.status) {
            case RestaurantUpdateStatus.initial:
              return const LoadingView();
            case RestaurantUpdateStatus.loading:
              return const LoadingView();
            case RestaurantUpdateStatus.success:
              return const RestaurantUpdateForm();
            case RestaurantUpdateStatus.editing:
              return const RestaurantUpdateForm();
            case RestaurantUpdateStatus.submitting:
              return const SubmittingView();
            case RestaurantUpdateStatus.failure:
              return const ErrorView();
            case RestaurantUpdateStatus.submitted:
              return const SubmittingView();
          }
        },
      ),
    );
  }

  void _handleBlocState(BuildContext context, RestaurantUpdateState state) {
    if (state.status == RestaurantUpdateStatus.failure) {
      _showSnackBar(context, 'Bir hata oluştu', isError: true);
    } else if (state.status == RestaurantUpdateStatus.submitted) {
      _showSnackBar(context, 'Restoran başarıyla güncellendi');
      context.go(AppRouteName.restaurantHome.path);
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
        ),
      );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class SubmittingView extends StatelessWidget {
  const SubmittingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Restoran güncelleniyor...'),
          ],
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bir hata oluştu'),
            ElevatedButton(
              onPressed: () => context
                  .read<RestaurantUpdateBloc>()
                  .add(const RestaurantDetailRequested('')),
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantUpdateForm extends StatelessWidget {
  const RestaurantUpdateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: RestaurantUpdateFormBody(),
      ),
    );
  }
}

class RestaurantUpdateFormBody extends StatelessWidget {
  const RestaurantUpdateFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: const [
        _AddImageRow(),
        SizedBox(height: 40),
        _RestaurantNameInput(),
        _RestaurantDescriptionInput(),
        _RestaurantAddressInput(),
        _RestaurantContactInput(),
        _CityPicker(),
        SizedBox(height: 12),
        _DistrictPicker(),
        SizedBox(height: 12),
        _MapPicker(),
        SizedBox(height: 12),
        _SubmitButton(),
        SizedBox(height: 20),
      ],
    );
  }
}

class _AddImageRow extends StatefulWidget {
  const _AddImageRow();

  @override
  State<_AddImageRow> createState() => _AddImageRowState();
}

class _AddImageRowState extends State<_AddImageRow> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (selectedImage != null) {
      final bytes = await selectedImage.readAsBytes();
      final base64Image = base64Encode(bytes);
      if (!mounted) return;

      setState(() {
        _imageFile = selectedImage;
      });

      context
          .read<RestaurantUpdateBloc>()
          .add(RestaurantUpdateLogoChanged(base64Image));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantUpdateBloc>().state;

    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Logo Değiştir'),
        ),
        const SizedBox(height: 20),
        if (_imageFile != null)
          Image.file(
            File(_imageFile!.path),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          )
        else if (state.logoUrl.isNotEmpty)
          Image.network(
            '${EnvConf.baseUrl}/${state.logoUrl}?t=${DateTime.now().millisecondsSinceEpoch}',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Logo yüklenemedi.'));
            },
          )
        else
          const Center(child: Text('Henüz logo seçilmedi.')),
      ],
    );
  }
}

class _RestaurantNameInput extends StatelessWidget {
  const _RestaurantNameInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RestaurantUpdateBloc>();
    final state = context.watch<RestaurantUpdateBloc>().state;

    return AppTextField(
      initialValue: state.name.value,
      hintText: 'Restoran Adı',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.restaurant),
      onChanged: (name) => read.add(
        RestaurantUpdateNameChanged(name),
      ),
      errorText: state.name.displayError?.errorText(context, 'Restoran Adı'),
    );
  }
}

class _RestaurantDescriptionInput extends StatelessWidget {
  const _RestaurantDescriptionInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RestaurantUpdateBloc>();
    final state = context.watch<RestaurantUpdateBloc>().state;

    return AppTextField(
      initialValue: state.description.value,
      hintText: 'Restoran Açıklaması',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.description),
      onChanged: (description) => read.add(
        RestaurantUpdateDescriptionChanged(description),
      ),
      errorText: state.description.displayError?.errorText(context, 'Açıklama'),
    );
  }
}

class _RestaurantAddressInput extends StatelessWidget {
  const _RestaurantAddressInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RestaurantUpdateBloc>();
    final state = context.watch<RestaurantUpdateBloc>().state;

    return AppTextField(
      initialValue: state.address.value,
      hintText: 'Restoran Adresi',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.location_on),
      onChanged: (address) => read.add(
        RestaurantUpdateAddressChanged(address),
      ),
      errorText: state.address.displayError?.errorText(context, 'Adres'),
    );
  }
}

class _RestaurantContactInput extends StatelessWidget {
  const _RestaurantContactInput();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RestaurantUpdateBloc>();
    final state = context.watch<RestaurantUpdateBloc>().state;

    return AppTextField(
      initialValue: state.contact.value,
      hintText: 'Restoran Telefonu',
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      prefix: const Icon(Icons.phone),
      onChanged: (contact) => read.add(
        RestaurantUpdateContactChanged(contact),
      ),
      errorText: state.contact.displayError?.errorText(context, 'Telefon'),
    );
  }
}

class _CityPicker extends StatelessWidget {
  const _CityPicker();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantUpdateBloc>().state;
    final cities = turkeyCities.keys.toList().cast<String>()..sort();

    final currentValue =
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
              .read<RestaurantUpdateBloc>()
              .add(RestaurantUpdateCityChanged(newValue));
          context
              .read<RestaurantUpdateBloc>()
              .add(const RestaurantUpdateDistrictChanged(''));
        }
      },
    );
  }
}

class _DistrictPicker extends StatelessWidget {
  const _DistrictPicker();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantUpdateBloc>().state;
    final districts = state.city.value.isNotEmpty
        ? turkeyCities[state.city.value]?.cast<String>() ?? <String>[]
        : <String>[];

    final currentValue = state.district.value.isNotEmpty &&
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
                    .read<RestaurantUpdateBloc>()
                    .add(RestaurantUpdateDistrictChanged(newValue));
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
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      _currentLocation = const LatLng(41.0082, 28.9784);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantUpdateBloc, RestaurantUpdateState>(
      builder: (context, state) {
        final initialLocation = state.latitude != 0.0 && state.longitude != 0.0
            ? LatLng(state.latitude, state.longitude)
            : _currentLocation ?? const LatLng(41.0082, 28.9784);

        return SizedBox(
          height: 300,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: initialLocation,
              initialZoom: 15,
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedLocation = point;
                });
                context.read<RestaurantUpdateBloc>().add(
                      RestaurantUpdateLocationChanged(
                        point.latitude,
                        point.longitude,
                      ),
                    );
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    point: initialLocation,
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
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantUpdateBloc, RestaurantUpdateState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        final isSubmitting = state.status == RestaurantUpdateStatus.submitting;
        final canSubmit = state.isValid &&
            state.status != RestaurantUpdateStatus.submitting &&
            state.status != RestaurantUpdateStatus.loading;

        return AppElevatedButton(
          onPressed: canSubmit
              ? () {
                  FocusScope.of(context).unfocus();
                  context.read<RestaurantUpdateBloc>().add(
                        RestaurantUpdateSubmitted(
                          state.name.value,
                          state.description.value,
                          state.address.value,
                          state.contact.value,
                          state.city.value,
                          state.district.value,
                          state.latitude,
                          state.longitude,
                          state.logoBase64,
                        ),
                      );
                }
              : null,
          child: isSubmitting
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : const Text('Restoran Güncelle'),
        );
      },
    );
  }
}

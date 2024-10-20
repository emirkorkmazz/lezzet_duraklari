part of 'add_restaurant_bloc.dart';

enum AddRestaurantStatus {
  unknown,
  loading,
  failure,
  edit,
  success,
}

final class AddRestaurantState extends Equatable {
  const AddRestaurantState({
    this.name = const NameInput.pure(),
    this.description = const NameInput.pure(),
    this.address = const NameInput.pure(),
    this.contact = const PhoneNumberInput.pure(),
    this.city = const NameInput.pure(),
    this.district = const NameInput.pure(),
    this.menu = const NameInput.pure(),
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.logoBase64 = '',
    this.isValid = false,
    this.status = AddRestaurantStatus.unknown,
  });

  final NameInput name;
  final NameInput description;
  final NameInput address;
  final PhoneNumberInput contact;
  final NameInput city;
  final NameInput district;
  final NameInput menu;
  final double latitude;
  final double longitude;
  final String logoBase64;
  final bool isValid;
  final AddRestaurantStatus status;

  AddRestaurantState copyWith({
    NameInput? name,
    NameInput? description,
    NameInput? address,
    PhoneNumberInput? contact,
    NameInput? city,
    NameInput? district,
    NameInput? menu,
    double? latitude,
    double? longitude,
    String? logoBase64,
    bool? isValid,
    AddRestaurantStatus? status,
  }) {
    return AddRestaurantState(
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      city: city ?? this.city,
      district: district ?? this.district,
      menu: menu ?? this.menu,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      logoBase64: logoBase64 ?? this.logoBase64,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        name,
        description,
        address,
        contact,
        city,
        district,
        menu,
        latitude,
        longitude,
        logoBase64,
        isValid,
        status,
      ];
}

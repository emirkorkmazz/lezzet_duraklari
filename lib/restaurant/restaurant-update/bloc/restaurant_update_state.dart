part of 'restaurant_update_bloc.dart';

enum RestaurantUpdateStatus {
  initial, // başlangıç durumu
  loading, // veri yüklenirken
  success, // veriler başarıyla yüklendiğinde
  failure, // hata durumunda
  submitting, // kaydetme işlemi sırasında
  submitted, // başarıyla kaydedildiğinde
  editing, // fotoğraf eklendiğinde/düzenlendiğinde
}

final class RestaurantUpdateState extends Equatable {
  const RestaurantUpdateState({
    this.name = const NameInput.pure(),
    this.description = const NameInput.pure(),
    this.address = const NameInput.pure(),
    this.contact = const PhoneNumberInput.pure(),
    this.city = const NameInput.pure(),
    this.district = const NameInput.pure(),
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.logoBase64 = '',
    this.logoUrl = '',
    this.isValid = false,
    this.status = RestaurantUpdateStatus.initial,
  });

  final NameInput name;
  final NameInput description;
  final NameInput address;
  final PhoneNumberInput contact;
  final NameInput city;
  final NameInput district;
  final double latitude;
  final double longitude;
  final String logoBase64;
  final String logoUrl;
  final bool isValid;
  final RestaurantUpdateStatus status;

  RestaurantUpdateState copyWith({
    NameInput? name,
    NameInput? description,
    NameInput? address,
    PhoneNumberInput? contact,
    NameInput? city,
    NameInput? district,
    double? latitude,
    double? longitude,
    String? logoBase64,
    String? logoUrl,
    bool? isValid,
    RestaurantUpdateStatus? status,
  }) {
    return RestaurantUpdateState(
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      logoBase64: logoBase64 ?? this.logoBase64,
      logoUrl: logoUrl ?? this.logoUrl,
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
        latitude,
        longitude,
        logoBase64,
        logoUrl,
        isValid,
        status,
      ];
}

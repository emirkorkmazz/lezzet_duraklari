part of 'add_restaurant_bloc.dart';

sealed class AddRestaurantEvent extends Equatable {
  const AddRestaurantEvent();
  @override
  List<Object> get props => [];
}

final class AddRestaurantNameChanged extends AddRestaurantEvent {
  const AddRestaurantNameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

final class AddRestaurantDescriptionChanged extends AddRestaurantEvent {
  const AddRestaurantDescriptionChanged(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

final class AddRestaurantAddressChanged extends AddRestaurantEvent {
  const AddRestaurantAddressChanged(this.address);
  final String address;
  @override
  List<Object> get props => [address];
}

final class AddRestaurantContactChanged extends AddRestaurantEvent {
  const AddRestaurantContactChanged(this.contact);
  final String contact;
  @override
  List<Object> get props => [contact];
}

final class AddRestaurantCityChanged extends AddRestaurantEvent {
  const AddRestaurantCityChanged(this.city);
  final String city;
  @override
  List<Object> get props => [city];
}

final class AddRestaurantDistrictChanged extends AddRestaurantEvent {
  const AddRestaurantDistrictChanged(this.district);
  final String district;
  @override
  List<Object> get props => [district];
}

final class AddRestaurantLogoChanged extends AddRestaurantEvent {
  const AddRestaurantLogoChanged(this.logoBase64);
  final String logoBase64;
  @override
  List<Object> get props => [logoBase64];
}

class AddRestaurantLocationChanged extends AddRestaurantEvent {
  final double latitude;
  final double longitude;

  const AddRestaurantLocationChanged(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}

final class AddRestaurantSubmitted extends AddRestaurantEvent {
  const AddRestaurantSubmitted(
    this.name,
    this.description,
    this.address,
    this.contact,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
    this.logoBase64,
  );
  final String name;
  final String description;
  final String address;
  final String contact;
  final String city;
  final String district;
  final double latitude;
  final double longitude;
  final String logoBase64;
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
        logoBase64
      ];
}

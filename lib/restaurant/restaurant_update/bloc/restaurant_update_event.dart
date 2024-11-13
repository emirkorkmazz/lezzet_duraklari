part of 'restaurant_update_bloc.dart';

sealed class RestaurantUpdateEvent extends Equatable {
  const RestaurantUpdateEvent();
  @override
  List<Object> get props => [];
}

final class RestaurantUpdateNameChanged extends RestaurantUpdateEvent {
  const RestaurantUpdateNameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

final class RestaurantUpdateDescriptionChanged extends RestaurantUpdateEvent {
  const RestaurantUpdateDescriptionChanged(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

final class RestaurantUpdateAddressChanged extends RestaurantUpdateEvent {
  const RestaurantUpdateAddressChanged(this.address);
  final String address;
  @override
  List<Object> get props => [address];
}

final class RestaurantUpdateContactChanged extends RestaurantUpdateEvent {
  const RestaurantUpdateContactChanged(this.contact);
  final String contact;
  @override
  List<Object> get props => [contact];
}

final class RestaurantUpdateCityChanged extends RestaurantUpdateEvent {
  const RestaurantUpdateCityChanged(this.city);
  final String city;
  @override
  List<Object> get props => [city];
}

final class RestaurantUpdateDistrictChanged extends RestaurantUpdateEvent {
  const RestaurantUpdateDistrictChanged(this.district);
  final String district;
  @override
  List<Object> get props => [district];
}

final class RestaurantUpdateLogoChanged extends RestaurantUpdateEvent {
  const RestaurantUpdateLogoChanged(this.logoBase64);
  final String logoBase64;
  @override
  List<Object> get props => [logoBase64];
}

final class RestaurantUpdateLocationChanged extends RestaurantUpdateEvent {
  final double latitude;
  final double longitude;

  const RestaurantUpdateLocationChanged(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}

final class RestaurantDetailRequested extends RestaurantUpdateEvent {
  const RestaurantDetailRequested(this.restaurantId);
  final String restaurantId;
  @override
  List<Object> get props => [restaurantId];
}

final class RestaurantUpdateSubmitted extends RestaurantUpdateEvent {
  const RestaurantUpdateSubmitted(
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

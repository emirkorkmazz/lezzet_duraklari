import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

part 'restaurant_update_event.dart';
part 'restaurant_update_state.dart';

@Injectable()
class RestaurantUpdateBloc
    extends Bloc<RestaurantUpdateEvent, RestaurantUpdateState> {
  RestaurantUpdateBloc({
    required this.restaurantRepository,
    required this.storageRepository,
  }) : super(const RestaurantUpdateState()) {
    ///
    on<RestaurantDetailRequested>(_onRestaurantDetailRequested);

    ///
    on<RestaurantUpdateNameChanged>(_onNameChanged);

    ///
    on<RestaurantUpdateDescriptionChanged>(_onDescriptionChanged);

    ///
    on<RestaurantUpdateAddressChanged>(_onAddressChanged);

    ///
    on<RestaurantUpdateContactChanged>(_onContactChanged);

    ///
    on<RestaurantUpdateCityChanged>(_onCityChanged);

    ///
    on<RestaurantUpdateDistrictChanged>(_onDistrictChanged);

    ///
    on<RestaurantUpdateLogoChanged>(_onLogoChanged);

    ///
    on<RestaurantUpdateLocationChanged>(_onLocationChanged);

    ///
    on<RestaurantUpdateSubmitted>(_onSubmitted);
  }
  final IRestaurantRepository restaurantRepository;
  final IStorageRepository storageRepository;

  Future<void> _onRestaurantDetailRequested(
    RestaurantDetailRequested event,
    Emitter<RestaurantUpdateState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RestaurantUpdateStatus.loading));

      final result = await restaurantRepository.restaurantDetail(
        restaurantId: event.restaurantId,
      );

      await result.fold(
        (failure) async {
          emit(state.copyWith(status: RestaurantUpdateStatus.failure));
        },
        (response) async {
          if (response.restaurant != null) {
            final restaurant = response.restaurant!;

            emit(state.copyWith(
              name: NameInput.dirty(restaurant.name ?? ''),
              description: NameInput.dirty(restaurant.description ?? ''),
              address: NameInput.dirty(restaurant.address ?? ''),
              contact: PhoneNumberInput.dirty(restaurant.contact ?? ''),
              city: NameInput.dirty(restaurant.city ?? ''),
              district: NameInput.dirty(restaurant.district ?? ''),
              latitude: double.tryParse(restaurant.latitude ?? '0') ?? 0.0,
              longitude: double.tryParse(restaurant.longitude ?? '0') ?? 0.0,
              logoUrl: restaurant.logoUrl ?? '',
              status: RestaurantUpdateStatus.success,
              isValid: true,
            ));
          }
        },
      );
    } catch (e) {
      print('Hata oluştu: $e');
      emit(state.copyWith(status: RestaurantUpdateStatus.failure));
    }
  }

  /// [1 Name] alanı doldurulduğunda kontrol
  FutureOr<void> _onNameChanged(
    RestaurantUpdateNameChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    ///
    final name = NameInput.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: RestaurantUpdateStatus.editing,
        isValid: Formz.validate([
          name,
          state.description,
          state.address,
          state.contact,
          state.city,
          state.district
        ]),
      ),
    );
  }

  /// [2 Description] alanı doldurulduğunda kontrol
  FutureOr<void> _onDescriptionChanged(
    RestaurantUpdateDescriptionChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    final description = NameInput.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        status: RestaurantUpdateStatus.editing,
        isValid: Formz.validate([
          state.name,
          description,
          state.address,
          state.contact,
          state.city,
          state.district
        ]),
      ),
    );
  }

  /// [3 Address] alanı doldurulduğunda kontrol
  FutureOr<void> _onAddressChanged(
    RestaurantUpdateAddressChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    ///
    final address = NameInput.dirty(event.address);
    emit(
      state.copyWith(
        address: address,
        status: RestaurantUpdateStatus.editing,
        isValid: Formz.validate([
          state.name,
          state.description,
          address,
          state.contact,
          state.city,
          state.district
        ]),
      ),
    );
  }

  /// [4 Contact] alanı doldurulduğunda kontrol
  FutureOr<void> _onContactChanged(
    RestaurantUpdateContactChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    ///
    final contact = PhoneNumberInput.dirty(event.contact);
    emit(
      state.copyWith(
        contact: contact,
        status: RestaurantUpdateStatus.editing,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.address,
          contact,
          state.city,
          state.district
        ]),
      ),
    );
  }

  /// [5 City] alanı doldurulduğunda kontrol
  FutureOr<void> _onCityChanged(
    RestaurantUpdateCityChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    ///
    final city = NameInput.dirty(event.city);
    emit(
      state.copyWith(
        city: city,
        status: RestaurantUpdateStatus.editing,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.address,
          state.contact,
          city,
          state.district
        ]),
      ),
    );
  }

  /// [6 District] alanı doldurulduğunda kontrol
  FutureOr<void> _onDistrictChanged(
    RestaurantUpdateDistrictChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    ///
    final district = NameInput.dirty(event.district);
    emit(
      state.copyWith(
        district: district,
        status: RestaurantUpdateStatus.editing,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.address,
          state.contact,
          state.city,
          district
        ]),
      ),
    );
  }

  FutureOr<void> _onLogoChanged(
    RestaurantUpdateLogoChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    final logoBase64 = event.logoBase64;
    emit(state.copyWith(
      logoBase64: logoBase64,
      logoUrl: '', // Logo değiştiğinde eski URL'yi temizle
      status: RestaurantUpdateStatus.editing,
    ));
  }

  /// [9 Location] alanı doldurulduğunda kontrol
  FutureOr<void> _onLocationChanged(
    RestaurantUpdateLocationChanged event,
    Emitter<RestaurantUpdateState> emit,
  ) {
    emit(state.copyWith(
      latitude: event.latitude,
      longitude: event.longitude,
      status: RestaurantUpdateStatus.editing,
    ));
  }

  /// [9 Submit] butonuna basıldığında kontrol
  FutureOr<void> _onSubmitted(
    RestaurantUpdateSubmitted event,
    Emitter<RestaurantUpdateState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: RestaurantUpdateStatus.submitting));

    final restaurantId = await storageRepository.getRestaurantId();

    /// Request'i hazırlayalım
    final request = RestaurantUpdateRequest(
      id: restaurantId,
      name: state.name.value,
      description: state.description.value,
      address: state.address.value,
      contact: state.contact.value,
      logoBase64: event.logoBase64,
      city: state.city.value,
      district: state.district.value,
      latitude: event.latitude,
      longitude: event.longitude,
    );

    /// Metodu çağır
    final result =
        await restaurantRepository.updateRestaurant(request: request);

    ///
    result.fold(
      /// [Handle left]: Error Type
      (AuthFailure failure) => emit(
        state.copyWith(
          status: RestaurantUpdateStatus.failure,
        ),
      ),

      /// [Handle right]: Response Type
      (response) {
        return emit(
          state.copyWith(
            status: RestaurantUpdateStatus.submitted,
          ),
        );
      },
    );
  }
}

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

part 'add_restaurant_event.dart';
part 'add_restaurant_state.dart';

@Injectable()
class AddRestaurantBloc extends Bloc<AddRestaurantEvent, AddRestaurantState> {
  AddRestaurantBloc({
    required this.restaurantRepository,
  }) : super(const AddRestaurantState()) {
    ///
    on<AddRestaurantNameChanged>(_onNameChanged);

    ///
    on<AddRestaurantDescriptionChanged>(_onDescriptionChanged);

    ///
    on<AddRestaurantAddressChanged>(_onAddressChanged);

    ///
    on<AddRestaurantContactChanged>(_onContactChanged);

    ///
    on<AddRestaurantCityChanged>(_onCityChanged);

    ///
    on<AddRestaurantDistrictChanged>(_onDistrictChanged);

    ///
    on<AddRestaurantMenuChanged>(_onMenuChanged);

    ///
    on<AddRestaurantLogoChanged>(_onLogoChanged);

    ///
    on<AddRestaurantSubmitted>(_onSubmitted);
  }
  final IRestaurantRepository restaurantRepository;

  /// [1 Name] alanı doldurulduğunda kontrol
  FutureOr<void> _onNameChanged(
    AddRestaurantNameChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    ///
    final name = NameInput.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: AddRestaurantStatus.edit,
        isValid: Formz.validate([
          name,
          state.description,
          state.address,
          state.contact,
          state.city,
          state.district,
          state.menu
        ]),
      ),
    );
  }

  /// [2 Description] alanı doldurulduğunda kontrol
  FutureOr<void> _onDescriptionChanged(
    AddRestaurantDescriptionChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    final description = NameInput.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        status: AddRestaurantStatus.edit,
        isValid: Formz.validate([
          state.name,
          description,
          state.address,
          state.contact,
          state.city,
          state.district,
          state.menu
        ]),
      ),
    );
  }

  /// [3 Address] alanı doldurulduğunda kontrol
  FutureOr<void> _onAddressChanged(
    AddRestaurantAddressChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    ///
    final address = NameInput.dirty(event.address);
    emit(
      state.copyWith(
        address: address,
        status: AddRestaurantStatus.edit,
        isValid: Formz.validate([
          state.name,
          state.description,
          address,
          state.contact,
          state.city,
          state.district,
          state.menu
        ]),
      ),
    );
  }

  /// [4 Contact] alanı doldurulduğunda kontrol
  FutureOr<void> _onContactChanged(
    AddRestaurantContactChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    ///
    final contact = PhoneNumberInput.dirty(event.contact);
    emit(
      state.copyWith(
        contact: contact,
        status: AddRestaurantStatus.edit,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.address,
          contact,
          state.city,
          state.district,
          state.menu
        ]),
      ),
    );
  }

  /// [5 City] alanı doldurulduğunda kontrol
  FutureOr<void> _onCityChanged(
    AddRestaurantCityChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    ///
    final city = NameInput.dirty(event.city);
    emit(
      state.copyWith(
        city: city,
        status: AddRestaurantStatus.edit,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.address,
          state.contact,
          city,
          state.district,
          state.menu
        ]),
      ),
    );
  }

  /// [6 District] alanı doldurulduğunda kontrol
  FutureOr<void> _onDistrictChanged(
    AddRestaurantDistrictChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    ///
    final district = NameInput.dirty(event.district);
    emit(
      state.copyWith(
        district: district,
        status: AddRestaurantStatus.edit,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.address,
          state.contact,
          state.city,
          district,
          state.menu,
        ]),
      ),
    );
  }

  /// [7 Menu] alanı doldurulduğunda kontrol
  FutureOr<void> _onMenuChanged(
    AddRestaurantMenuChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    final menu = NameInput.dirty(event.menu);
    emit(state.copyWith(
      menu: menu,
      status: AddRestaurantStatus.edit,
      isValid: Formz.validate([
        state.name,
        state.description,
        state.address,
        state.contact,
        state.city,
        state.district,
        menu
      ]),
    ));
  }

  /// [8 Logo] alanı doldurulduğunda kontrol
  FutureOr<void> _onLogoChanged(
    AddRestaurantLogoChanged event,
    Emitter<AddRestaurantState> emit,
  ) {
    final logoBase64 = event.logoBase64;
    emit(state.copyWith(
      logoBase64: logoBase64,
      status: AddRestaurantStatus.edit,
    ));
  }

  /// [9 Submit] butonuna basıldığında kontrol
  FutureOr<void> _onSubmitted(
    AddRestaurantSubmitted event,
    Emitter<AddRestaurantState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: AddRestaurantStatus.loading));

    /// Request'i hazırlayalım
    final request = AddRestaurantRequest(
      name: state.name.value,
      description: state.description.value,
      address: state.address.value,
      contact: state.contact.value,
      menu: state.menu.value,
      logoBase64: event.logoBase64,
      city: state.city.value,
      district: state.district.value,
      latitude: event.latitude,
      longitude: event.longitude,
    );

    /// Metodu çağır
    final result = await restaurantRepository.addRestaurant(request: request);

    ///
    result.fold(
      /// [Handle left]: Error Type
      (AuthFailure failure) => emit(
        state.copyWith(
          status: AddRestaurantStatus.failure,
        ),
      ),

      /// [Handle right]: Response Type
      (response) {
        return emit(
          state.copyWith(
            status: AddRestaurantStatus.success,
          ),
        );
      },
    );
  }
}

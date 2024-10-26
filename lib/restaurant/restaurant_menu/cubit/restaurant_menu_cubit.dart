import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

part 'restaurant_menu_state.dart';

@Injectable()
class RestaurantMenuCubit extends Cubit<RestaurantMenuState> {
  RestaurantMenuCubit({
    required this.restaurantRepository,
    required this.storageRepository,
  }) : super(const RestaurantMenuState());

  final IRestaurantRepository restaurantRepository;
  final IStorageRepository storageRepository;

  Future<void> fetchMenuPhotos() async {
    emit(state.copyWith(
      status: RestaurantMenuStatus.loading,
      message: null,
    ));

    final restaurantId = await storageRepository.getRestaurantId();
    final result = await restaurantRepository.getMenuPhotos(
      request: GetMenuPhotosRequest(restaurantId: restaurantId),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: RestaurantMenuStatus.failure,
      )),
      (response) => emit(
        state.copyWith(
          status: RestaurantMenuStatus.success,
          menus: response.menus,
          message: null,
        ),
      ),
    );
  }

  Future<void> submitMenuPhotos() async {
    emit(state.copyWith(
      status: RestaurantMenuStatus.submitting,
      message: null,
    ));

    final restaurantId = await storageRepository.getRestaurantId();
    final request = AddMenuPhotosRequest(
      restaurantId: restaurantId,
      menu1: state.photo1.value.isNotEmpty ? state.photo1.value : null,
      menu2: state.photo2.value.isNotEmpty ? state.photo2.value : null,
      menu3: state.photo3.value.isNotEmpty ? state.photo3.value : null,
    );

    final result = await restaurantRepository.addMenuPhotos(request: request);

    result.fold(
      (failure) => emit(state.copyWith(
        status: RestaurantMenuStatus.failure,
        message: 'Fotoğraf yüklenirken bir hata oluştu',
      )),
      (response) => emit(state.copyWith(
        status: RestaurantMenuStatus.submitted,
        message: 'Menü fotoğrafları başarıyla kaydedildi',
      )),
    );

    await fetchMenuPhotos();
  }

  void updatePhoto1(PhotoInput photo1) {
    emit(
      state.copyWith(
        photo1: photo1,
        status: RestaurantMenuStatus.editing,
        message: 'Menü fotoğrafı başarıyla seçildi',
      ),
    );
    _resetToSuccess();
  }

  void updatePhoto2(PhotoInput photo2) {
    emit(
      state.copyWith(
        photo2: photo2,
        status: RestaurantMenuStatus.editing,
        message: 'Menü fotoğrafı başarıyla seçildi',
      ),
    );
    _resetToSuccess();
  }

  void updatePhoto3(PhotoInput photo3) {
    emit(
      state.copyWith(
        photo3: photo3,
        status: RestaurantMenuStatus.editing,
        message: 'Menü fotoğrafı başarıyla seçildi',
      ),
    );
    _resetToSuccess();
  }

  Future<void> deleteMenuPhotos({required String menuNumber}) async {
    emit(
      state.copyWith(
        status: RestaurantMenuStatus.deleting,
        message: null,
      ),
    );

    final restaurantId = await storageRepository.getRestaurantId();
    final request = DeleteMenuPhotoRequest(
      restaurantId: restaurantId,
      menuNumber: menuNumber,
    );

    final result = await restaurantRepository.deleteMenuPhoto(request: request);

    result.fold(
      (failure) => emit(state.copyWith(status: RestaurantMenuStatus.failure)),
      (response) {
        final PhotoInput emptyPhoto = const PhotoInput.pure();
        String successMessage;

        switch (menuNumber) {
          case 'menu1':
            successMessage = 'Menü 1 başarıyla silindi';
            emit(state.copyWith(
              photo1: emptyPhoto,
              status: RestaurantMenuStatus.deleted,
              message: successMessage,
            ));
            break;
          case 'menu2':
            successMessage = 'Menü 2 başarıyla silindi';
            emit(state.copyWith(
              photo2: emptyPhoto,
              status: RestaurantMenuStatus.deleted,
              message: successMessage,
            ));
            break;
          case 'menu3':
            successMessage = 'Menü 3 başarıyla silindi';
            emit(state.copyWith(
              photo3: emptyPhoto,
              status: RestaurantMenuStatus.deleted,
              message: successMessage,
            ));
            break;
        }
        _resetToSuccess();
      },
    );
  }

  Future<void> _resetToSuccess() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (state.status == RestaurantMenuStatus.editing ||
        state.status == RestaurantMenuStatus.deleted) {
      emit(state.copyWith(
        status: RestaurantMenuStatus.success,
        message: null,
      ));
    }
  }
}

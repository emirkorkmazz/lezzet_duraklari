import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

part 'restaurant_photo_state.dart';

@Injectable()
class RestaurantPhotoCubit extends Cubit<RestaurantPhotoState> {
  RestaurantPhotoCubit({
    required this.restaurantRepository,
    required this.storageRepository,
  }) : super(const RestaurantPhotoState());

  final IRestaurantRepository restaurantRepository;
  final IStorageRepository storageRepository;

  Future<void> fetchPhotos() async {
    emit(
      state.copyWith(
        status: RestaurantPhotoStatus.loading,
        message: null,
      ),
    );

    final restaurantId = await storageRepository.getRestaurantId();
    final result = await restaurantRepository.restaurantPhotoList(
      request: RestaurantPhotoListRequest(restaurantId: restaurantId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RestaurantPhotoStatus.failure,
        ),
      ),
      (response) => emit(
        state.copyWith(
          photos: response.photos,
          status: RestaurantPhotoStatus.success,
          message: null,
        ),
      ),
    );
  }

  void addPhoto(String base64String) {
    if (state.photos.length >= 3) return;

    // Yeni fotoğrafı geçici olarak state'e ekle
    final newPhoto = Photos(
      id: DateTime.now().toString(), // Geçici bir ID
      photoUrl: base64String,
      createdAt: DateTime.now().toString(),
    );

    emit(state.copyWith(
      photos: [...state.photos, newPhoto],
      status: RestaurantPhotoStatus.editing,
      message: 'Fotoğraf eklendi',
    ));

    _resetToSuccess();
  }

  Future<void> savePhotos() async {
    if (state.photos.isEmpty) return;

    emit(state.copyWith(
      status: RestaurantPhotoStatus.submitting,
      message: null,
    ));

    final restaurantId = await storageRepository.getRestaurantId();
    final request = RestaurantPhotoAddRequest(
      restaurantId: restaurantId,
      photosBase64: state.photos
          .where((photo) => !photo.photoUrl!.startsWith('http'))
          .map((photo) => photo.photoUrl!)
          .toList(),
    );

    final result =
        await restaurantRepository.restaurantPhotoAdd(request: request);

    result.fold(
      (failure) => emit(state.copyWith(
        status: RestaurantPhotoStatus.failure,
        message: 'Fotoğraflar kaydedilirken bir hata oluştu',
      )),
      (response) => emit(state.copyWith(
        status: RestaurantPhotoStatus.submitted,
        message: 'Fotoğraflar başarıyla kaydedildi',
      )),
    );

    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: RestaurantPhotoStatus.success));
  }

  /* void updatePhoto1(PhotoInput photo1) {
    emit(
      state.copyWith(
        photo1: photo1,
        status: RestaurantPhotoStatus.editing,
        message: 'Restoran resmi başarıyla seçildi',
      ),
    );
    _resetToSuccess();
  }
*/
  /*
  void updatePhoto2(PhotoInput photo2) {
    emit(
      state.copyWith(
        photo2: photo2,
        status: RestaurantPhotoStatus.editing,
        message: 'Restoran resmi başarıyla seçildi',
      ),
    );
    _resetToSuccess();
  }
  */
  /*
  void updatePhoto3(PhotoInput photo3) {
    emit(
      state.copyWith(
        photo3: photo3,
        status: RestaurantPhotoStatus.editing,
        message: 'Restoran resmi başarıyla seçildi',
      ),
    );
    _resetToSuccess();
  }
  */
  Future<void> deletePhoto({required String id}) async {
    emit(
      state.copyWith(
        status: RestaurantPhotoStatus.deleting,
        message: null,
      ),
    );

    final request = RestaurantPhotoDeleteRequest(id: id);
    final result =
        await restaurantRepository.restaurantPhotoDelete(request: request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RestaurantPhotoStatus.failure,
          message: 'Fotoğraf silinirken bir hata oluştu',
        ),
      ),
      (response) {
        // Silinen fotoğrafı state'ten kaldır
        final updatedPhotos = List<Photos>.from(state.photos)
          ..removeWhere((photo) => photo.id == id);

        emit(
          state.copyWith(
            photos: updatedPhotos,
            status: RestaurantPhotoStatus.deleted,
            message: 'Fotoğraf başarıyla silindi',
          ),
        );
        _resetToSuccess();
      },
    );
  }

  Future<void> _resetToSuccess() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (state.status == RestaurantPhotoStatus.editing ||
        state.status == RestaurantPhotoStatus.deleted) {
      emit(
        state.copyWith(
          status: RestaurantPhotoStatus.success,
          message: null,
        ),
      );
    }
  }
}

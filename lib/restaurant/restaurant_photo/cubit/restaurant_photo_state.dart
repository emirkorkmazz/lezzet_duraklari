part of 'restaurant_photo_cubit.dart';

enum RestaurantPhotoStatus {
  initial, // başlangıç durumu
  loading, // veri yüklenirken
  success, // veriler başarıyla yüklendiğinde
  failure, // hata durumunda
  submitting, // kaydetme işlemi sırasında
  submitted, // başarıyla kaydedildiğinde
  editing, // fotoğraf eklendiğinde/düzenlendiğinde
  deleting, // silme işlemi sırasında
  deleted, // başarıyla silindiğinde
}

final class RestaurantPhotoState extends Equatable {
  const RestaurantPhotoState({
    this.photos = const [],
    this.photo1 = const PhotoInput.pure(),
    this.photo2 = const PhotoInput.pure(),
    this.photo3 = const PhotoInput.pure(),
    this.status = RestaurantPhotoStatus.loading,
    this.message,
  });

  final List<Photos> photos;
  final PhotoInput photo1;
  final PhotoInput photo2;
  final PhotoInput photo3;
  final RestaurantPhotoStatus status;
  final String? message;

  RestaurantPhotoState copyWith({
    List<Photos>? photos,
    PhotoInput? photo1,
    PhotoInput? photo2,
    PhotoInput? photo3,
    bool? isValid,
    RestaurantPhotoStatus? status,
    String? message,
  }) {
    return RestaurantPhotoState(
      photos: photos ?? this.photos,
      photo1: photo1 ?? this.photo1,
      photo2: photo2 ?? this.photo2,
      photo3: photo3 ?? this.photo3,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        photos,
        photo1,
        photo2,
        photo3,
        status,
        message,
      ];
}

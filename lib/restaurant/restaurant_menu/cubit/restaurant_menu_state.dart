part of 'restaurant_menu_cubit.dart';

enum RestaurantMenuStatus {
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

final class RestaurantMenuState extends Equatable {
  const RestaurantMenuState({
    this.photo1 = const PhotoInput.pure(),
    this.photo2 = const PhotoInput.pure(),
    this.photo3 = const PhotoInput.pure(),
    this.status = RestaurantMenuStatus.loading,
    this.message,
    this.menus,
  });

  final PhotoInput photo1;
  final PhotoInput photo2;
  final PhotoInput photo3;
  final RestaurantMenuStatus status;
  final Menus? menus;
  final String? message;
  RestaurantMenuState copyWith({
    PhotoInput? photo1,
    PhotoInput? photo2,
    PhotoInput? photo3,
    bool? isValid,
    RestaurantMenuStatus? status,
    Menus? menus,
    String? message,
  }) {
    return RestaurantMenuState(
      photo1: photo1 ?? this.photo1,
      photo2: photo2 ?? this.photo2,
      photo3: photo3 ?? this.photo3,
      status: status ?? this.status,
      menus: menus ?? this.menus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        photo1,
        photo2,
        photo3,
        status,
        menus,
        message,
      ];
}

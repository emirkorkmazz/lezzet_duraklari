import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

abstract class IRestaurantRepository {
  Future<Either<AuthFailure, AddRestaurantResponse>> addRestaurant({
    required AddRestaurantRequest request,
  });

  Future<Either<AuthFailure, AddMenuPhotosResponse>> addMenuPhotos({
    required AddMenuPhotosRequest request,
  });

  Future<Either<AuthFailure, GetMenuPhotosResponse>> getMenuPhotos({
    required GetMenuPhotosRequest request,
  });

  Future<Either<AuthFailure, DeleteMenuPhotoResponse>> deleteMenuPhoto({
    required DeleteMenuPhotoRequest request,
  });
}

@Singleton(as: IRestaurantRepository)
class RestaurantRepository implements IRestaurantRepository {
  ///
  RestaurantRepository({
    required this.restaurantClient,
  });

  ///
  final RestaurantClient restaurantClient;

  ///
  @override
  Future<Either<AuthFailure, AddRestaurantResponse>> addRestaurant({
    required AddRestaurantRequest request,
  }) async {
    /// [Restaurant Ekle]
    try {
      final response = await restaurantClient.addRestaurant(request);

      /// Kullanıcı [Restaurant Ekleme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Ekleme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Ekleme İşlemi Başarılı ise]
      return Right(response);
    } catch (e) {
      return Left(
        AuthFailure(
          message: '$e',
        ),
      );
    }
  }

  ///
  Future<Either<AuthFailure, AddMenuPhotosResponse>> addMenuPhotos({
    required AddMenuPhotosRequest request,
  }) async {
    try {
      final response = await restaurantClient.addMenuPhotos(request);

      /// Kullanıcı [Restaurant Menü Ekleme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Menü Ekleme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Menü Ekleme İşlemi Başarılı ise]
      return Right(response);
    } catch (e) {
      return Left(
        AuthFailure(
          message: '$e',
        ),
      );
    }
  }

  ///
  Future<Either<AuthFailure, GetMenuPhotosResponse>> getMenuPhotos({
    required GetMenuPhotosRequest request,
  }) async {
    /// [Restaurant Menü Getir]
    try {
      final response = await restaurantClient.getMenuPhotos(request);

      /// Kullanıcı [Restaurant Menü Getirme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Menü Getirme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Menü Getirme İşlemi Başarılı ise]
      return Right(response);
    } catch (e) {
      return Left(
        AuthFailure(
          message: '$e',
        ),
      );
    }
  }

  ///
  Future<Either<AuthFailure, DeleteMenuPhotoResponse>> deleteMenuPhoto({
    required DeleteMenuPhotoRequest request,
  }) async {
    /// [Restaurant Menü Sil]
    try {
      final response = await restaurantClient.deleteMenuPhoto(request);

      /// Kullanıcı [Restaurant Menü Silme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Menü Silme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Menü Silme İşlemi Başarılı ise]
      return Right(response);
    } catch (e) {
      return Left(
        AuthFailure(
          message: '$e',
        ),
      );
    }
  }
}

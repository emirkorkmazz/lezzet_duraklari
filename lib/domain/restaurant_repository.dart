import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '/core/core.dart';
import '/data/data.dart';

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

  Future<Either<AuthFailure, RestaurantReviewsListResponse>>
      restaurantReviewsList({
    required RestaurantReviewsListRequest request,
  });

  Future<Either<AuthFailure, ReviewReplyResponse>> reviewReply({
    required ReviewReplyRequest request,
  });

  Future<Either<AuthFailure, RestaurantUpdateResponse>> updateRestaurant({
    required RestaurantUpdateRequest request,
  });

  Future<Either<AuthFailure, RestaurantDetailResponse>> restaurantDetail({
    required String restaurantId,
  });

  Future<Either<AuthFailure, RestaurantPhotoListResponse>> restaurantPhotoList({
    required RestaurantPhotoListRequest request,
  });

  Future<Either<AuthFailure, RestaurantPhotoDeleteResponse>>
      restaurantPhotoDelete({
    required RestaurantPhotoDeleteRequest request,
  });

  Future<Either<AuthFailure, RestaurantPhotoAddResponse>> restaurantPhotoAdd({
    required RestaurantPhotoAddRequest request,
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

  ///
  Future<Either<AuthFailure, RestaurantReviewsListResponse>>
      restaurantReviewsList({
    required RestaurantReviewsListRequest request,
  }) async {
    try {
      final response = await restaurantClient.restaurantReviewsList(request);

      /// Kullanıcı [Restaurant Yorumları Getirme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Yorumları Getirme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Yorumları Getirme İşlemi Başarılı ise]
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
  Future<Either<AuthFailure, ReviewReplyResponse>> reviewReply({
    required ReviewReplyRequest request,
  }) async {
    try {
      final response = await restaurantClient.reviewReply(request);

      /// Kullanıcı [Restaurant Yorumu Yanıtı Gönder] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Yorumu Yanıtı Gönder İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Yorumu Yanıtı Gönder İşlemi Başarılı ise]
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
  Future<Either<AuthFailure, RestaurantDetailResponse>> restaurantDetail({
    required String restaurantId,
  }) async {
    try {
      final response = await restaurantClient.getRestaurantById(restaurantId);

      /// Kullanıcı [Restaurant Detayı Getirme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Detayı Getirme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Detayı Getirme İşlemi Başarılı ise]
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
  Future<Either<AuthFailure, RestaurantUpdateResponse>> updateRestaurant({
    required RestaurantUpdateRequest request,
  }) async {
    try {
      final response = await restaurantClient.updateRestaurant(request);

      /// Kullanıcı [Restaurant Güncelleme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Güncelleme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Güncelleme İşlemi Başarılı ise]
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
  Future<Either<AuthFailure, RestaurantPhotoListResponse>> restaurantPhotoList({
    required RestaurantPhotoListRequest request,
  }) async {
    try {
      final response = await restaurantClient.restaurantPhotoList(request);

      /// Kullanıcı [Restaurant Resimleri Getirme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Resimleri Getirme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Resimleri Getirme İşlemi Başarılı ise]
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
  Future<Either<AuthFailure, RestaurantPhotoDeleteResponse>>
      restaurantPhotoDelete({
    required RestaurantPhotoDeleteRequest request,
  }) async {
    try {
      final response = await restaurantClient.restaurantPhotoDelete(request);

      /// Kullanıcı [Restaurant Resim Silme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Resim Silme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Resim Silme İşlemi Başarılı ise]
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
  Future<Either<AuthFailure, RestaurantPhotoAddResponse>> restaurantPhotoAdd({
    required RestaurantPhotoAddRequest request,
  }) async {
    try {
      final response = await restaurantClient.addRestaurantPhoto(request);

      /// Kullanıcı [Restaurant Resim Ekleme] işlemi [Başarısız] ise
      if (response.status == null || !response.status!) {
        return const Left(
          AuthFailure(
            message: 'Restaurant Resim Ekleme İşlemi Başarısız',
          ),
        );
      }

      /// [Restaurant Resim Ekleme İşlemi Başarılı ise]
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

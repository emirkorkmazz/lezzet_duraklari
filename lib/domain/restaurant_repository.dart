import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

abstract class IRestaurantRepository {
  Future<Either<AuthFailure, AddRestaurantResponse>> addRestaurant({
    required AddRestaurantRequest request,
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
}

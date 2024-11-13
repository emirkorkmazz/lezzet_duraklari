// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lezzet_duraklari/auth/login/bloc/login_bloc.dart' as _i851;
import 'package:lezzet_duraklari/auth/register/bloc/register_bloc.dart'
    as _i151;
import 'package:lezzet_duraklari/core/di/register_module.dart' as _i273;
import 'package:lezzet_duraklari/data/data.dart' as _i85;
import 'package:lezzet_duraklari/domain/auth_repository.dart' as _i480;
import 'package:lezzet_duraklari/domain/domain.dart' as _i737;
import 'package:lezzet_duraklari/domain/restaurant_repository.dart' as _i666;
import 'package:lezzet_duraklari/domain/storage_repository.dart' as _i125;
import 'package:lezzet_duraklari/restaurant/add_restaurant/bloc/add_restaurant_bloc.dart'
    as _i500;
import 'package:lezzet_duraklari/restaurant/restaurant_menu/cubit/restaurant_menu_cubit.dart'
    as _i444;
import 'package:lezzet_duraklari/restaurant/restaurant_photo/cubit/restaurant_photo_cubit.dart'
    as _i373;
import 'package:lezzet_duraklari/restaurant/restaurant_review/cubit/restaurant_review_cubit.dart'
    as _i569;
import 'package:lezzet_duraklari/restaurant/restaurant_update/bloc/restaurant_update_bloc.dart'
    as _i818;
import 'package:lezzet_duraklari/restaurant/review_reply/bloc/review_reply_bloc.dart'
    as _i317;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.unsecuredStorage,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i85.AuthClient>(() => registerModule.authClient);
    gh.singleton<_i85.RestaurantClient>(() => registerModule.restaurantClient);
    gh.singleton<_i558.FlutterSecureStorage>(
        () => registerModule.securedStorage);
    gh.singleton<_i666.IRestaurantRepository>(() => _i666.RestaurantRepository(
        restaurantClient: gh<_i85.RestaurantClient>()));
    gh.factory<_i317.ReviewReplyBloc>(() => _i317.ReviewReplyBloc(
        restaurantRepository: gh<_i737.IRestaurantRepository>()));
    gh.factory<_i500.AddRestaurantBloc>(() => _i500.AddRestaurantBloc(
        restaurantRepository: gh<_i737.IRestaurantRepository>()));
    gh.factory<_i125.IStorageRepository>(() => _i125.StorageRepository(
          securedStorage: gh<_i558.FlutterSecureStorage>(),
          unsecuredStorage: gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i444.RestaurantMenuCubit>(() => _i444.RestaurantMenuCubit(
          restaurantRepository: gh<_i737.IRestaurantRepository>(),
          storageRepository: gh<_i737.IStorageRepository>(),
        ));
    gh.factory<_i569.RestaurantReviewCubit>(() => _i569.RestaurantReviewCubit(
          restaurantRepository: gh<_i737.IRestaurantRepository>(),
          storageRepository: gh<_i737.IStorageRepository>(),
        ));
    gh.factory<_i373.RestaurantPhotoCubit>(() => _i373.RestaurantPhotoCubit(
          restaurantRepository: gh<_i737.IRestaurantRepository>(),
          storageRepository: gh<_i737.IStorageRepository>(),
        ));
    gh.factory<_i818.RestaurantUpdateBloc>(() => _i818.RestaurantUpdateBloc(
          restaurantRepository: gh<_i737.IRestaurantRepository>(),
          storageRepository: gh<_i737.IStorageRepository>(),
        ));
    gh.singleton<_i480.IAuthRepository>(() => _i480.AuthRepository(
          authClient: gh<_i85.AuthClient>(),
          storageRepository: gh<_i737.IStorageRepository>(),
        ));
    gh.factory<_i151.RegisterBloc>(
        () => _i151.RegisterBloc(authRepository: gh<_i737.IAuthRepository>()));
    gh.factory<_i851.LoginBloc>(
        () => _i851.LoginBloc(authRepository: gh<_i737.IAuthRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i273.RegisterModule {}

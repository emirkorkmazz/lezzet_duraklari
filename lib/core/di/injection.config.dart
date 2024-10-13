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
import 'package:lezzet_duraklari/core/di/register_module.dart' as _i273;
import 'package:lezzet_duraklari/data/data.dart' as _i85;
import 'package:lezzet_duraklari/domain/storage_repository.dart' as _i125;
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
    gh.singleton<_i558.FlutterSecureStorage>(
        () => registerModule.securedStorage);
    gh.factory<_i125.IStorageRepository>(() => _i125.StorageRepository(
          securedStorage: gh<_i558.FlutterSecureStorage>(),
          unsecuredStorage: gh<_i460.SharedPreferences>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i273.RegisterModule {}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/core.dart';

abstract class IStorageRepository {
  /// AuthInterceptor'da Token isteyen endpoint'lerin
  /// request header'ına ekleyeceğiz
  Future<String?> getToken();
  Future<void> setToken(String? value);

  /// AuthInterceptor'da Refresh Token isteyen endpoint'lerin
  /// request header'ına ekleyeceğiz
  Future<String?> getRefreshToken();
  Future<void> setRefreshToken(String? value);

  /// Uygulamanın cihazda ilk defa açılıp-açılmadığını kontrol
  /// GoRouter'ın redirect parametresinde sorgulayacağız
  Future<bool?> getIsFirstTimeAppOpen();
  Future<void> setIsFirstTimeAppOpen({bool isFirstTimeAppOpen = true});

  /// Kullanıcının oturum açıp-açmadığını kontrol
  /// GoRouter'ın redirect parametresinde sorgulayacağız
  Future<bool?> getIsLogged();
  Future<void> setIsLogged({bool isLogged = false});

  /// Restaurant ID'yi Cache'le
  Future<String?> getRestaurantId();
  Future<void> setRestaurantId(String? value);
}

@Injectable(as: IStorageRepository)
class StorageRepository implements IStorageRepository {
  ///
  const StorageRepository({
    required this.securedStorage,
    required this.unsecuredStorage,
  });

  ///
  final FlutterSecureStorage securedStorage;
  final SharedPreferences unsecuredStorage;

  @override
  Future<String?> getToken() => securedStorage.read(
        key: AppStorage.token.key,
      );

  @override
  Future<void> setToken(String? value) => securedStorage.write(
        key: AppStorage.token.key,
        value: value,
      );

  @override
  Future<String?> getRefreshToken() => securedStorage.read(
        key: AppStorage.refreshToken.key,
      );

  @override
  Future<void> setRefreshToken(String? value) => securedStorage.write(
        key: AppStorage.refreshToken.key,
        value: value,
      );
  @override
  Future<String?> getRestaurantId() async {
    final String? restaurantId = await unsecuredStorage.getString(
      AppStorage.restaurantId.key,
    );
    return restaurantId;
  }

  @override
  Future<void> setRestaurantId(String? value) async {
    await unsecuredStorage.setString(
      AppStorage.restaurantId.key,
      value ?? '',
    );
  }

  @override
  Future<bool?> getIsFirstTimeAppOpen() async => unsecuredStorage.getBool(
        AppStorage.isFirstTimeAppOpen.key,
      );

  @override
  Future<void> setIsFirstTimeAppOpen({
    bool isFirstTimeAppOpen = false,
  }) async =>
      unsecuredStorage.setBool(
        AppStorage.isFirstTimeAppOpen.key,
        isFirstTimeAppOpen,
      );

  @override
  Future<bool?> getIsLogged() async => unsecuredStorage.getBool(
        AppStorage.isLoggedIn.key,
      );

  @override
  Future<void> setIsLogged({bool isLogged = false}) async =>
      unsecuredStorage.setBool(
        AppStorage.isLoggedIn.key,
        isLogged,
      );
}

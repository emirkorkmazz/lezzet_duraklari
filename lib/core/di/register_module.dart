import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/core.dart';
import '/data/data.dart';

@module
abstract class RegisterModule {
  ///
  @singleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: EnvConf.baseUrl,
        ),
      )
        ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
        ))
        ..interceptors.add(TokenInterceptor());

  @singleton
  AuthClient get authClient =>
      AuthClient(dio..interceptors.add(PrettyDioLogger()));

  @singleton
  RestaurantClient get restaurantClient =>
      RestaurantClient(dio..interceptors.add(PrettyDioLogger()));

  ///
  @singleton
  FlutterSecureStorage get securedStorage => const FlutterSecureStorage();

  @preResolve
  Future<SharedPreferences> get unsecuredStorage =>
      SharedPreferences.getInstance();
}

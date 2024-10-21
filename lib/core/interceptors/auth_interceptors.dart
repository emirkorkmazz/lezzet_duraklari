import 'package:dio/dio.dart';
import '/core/core.dart';
import '/domain/domain.dart';

class TokenInterceptor extends Interceptor {
  const TokenInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /// Diğer tüm endpoint'ler için accessToken eklenir.
    final token = await getIt<IStorageRepository>().getToken();

    if (token != null && token.isNotEmpty) {
      /// Alınan token'ı Authorization header'ına ekle
      options.headers['Authorization'] = 'Bearer $token';
    }

    /// İstek devam etsin
    return handler.next(options);
  }

  /// [Response Interceptor]
  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    /// Yanıt devam etsin
    return handler.next(response);
  }

  /// [Error Interceptor]
  @override
  Future<void> onError(
    DioException dioException,
    ErrorInterceptorHandler handler,
  ) async {
    final storageRepository = getIt<IStorageRepository>();

    if (dioException.response?.statusCode == 403) {
      // 403 hatası aldıysak refresh token endpoint'ine istek yapacağız
      final refreshToken = await storageRepository.getRefreshToken();

      if (refreshToken != null) {
        try {
          // refresh token için istek yap
          final dio = Dio();

          final refreshResponse = await dio.post(
            '${EnvConf.baseUrl}${AppUrls.refreshToken}',
            data: {'refreshToken': refreshToken},
          );

          if (refreshResponse.statusCode == 200) {
            final newToken = refreshResponse.data['token'] as String?;

            // Yeni token'ı storage'a kaydet
            await storageRepository.setToken(newToken);

            // Orijinal isteği yeni token ile yeniden dene
            final RequestOptions requestOptions = dioException.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newToken';

            // Yeni istek ile işlemi tamamla
            final response = await Dio().fetch(requestOptions);
            return handler.resolve(response);
          } else {
            // Eğer refresh-token isteği başarısız olursa oturumu sonlandır
            await _handleLogout(handler);
          }
        } catch (e) {
          // Refresh token isteği başarısız olursa oturumu sonlandır
          await _handleLogout(handler);
        }
      } else {
        // Token yoksa oturumu sonlandır
        await _handleLogout(handler);
      }
    } else {
      // Diğer hatalar için orijinal hatayı işleyelim
      return handler.next(dioException);
    }
  }

  /// Kullanıcıyı çıkış yaptırıp giriş ekranına yönlendiren yardımcı fonksiyon
  Future<void> _handleLogout(ErrorInterceptorHandler handler) async {
    final storageRepository = getIt<IStorageRepository>();

    // Token'ı ve oturum bilgilerini temizle
    await storageRepository.setToken(null);
    await storageRepository.setIsLogged(isLogged: false);

    // Giriş sayfasına yönlendirme (GoRouter ya da benzeri bir router kullanılabilir)
    // context.go(AppRouteName.login.path);  // context'e erişim yoksa üst seviye bir yönlendirme çözümü kullan

    // 401 hatası ile devam et
    handler.next(DioError(
      requestOptions: RequestOptions(path: ''),
      error: 'Unauthorized - Session expired',
    ));
  }
}

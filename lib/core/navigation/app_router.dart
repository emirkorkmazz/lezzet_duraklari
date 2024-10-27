import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/auth/auth.dart';
import '/core/core.dart';
import '/domain/domain.dart';
import '/startup/startup.dart';
import '/restaurant/restaurant.dart';

/// Uygulamanın Ana Navigator'unu yönetmesi için GlobalKey.
final rootNavigatorKey = GlobalKey<NavigatorState>();
final appRouter = GoRouter(
  /// Ana Navigator anahtarını bu parametreye veriyoruz.
  navigatorKey: rootNavigatorKey,

  /// Başlangıç konumu
  initialLocation: '/',

  /// Debug için logları etkinleştir
  debugLogDiagnostics: true,

  /// Kullanıcı girişi doğrulama
  redirect: _routeGuard,

  /// Rotalar
  routes: _routes,
);
List<RouteBase> get _routes {
  return [
    // Root rotayı '/landing'e yönlendirin
    GoRoute(
      path: '/',
      redirect: (context, state) => '/landing',
    ),

    /// Landing Ekranı için Rota
    GoRoute(
      path: AppRouteName.landing.path,
      name: AppRouteName.landing.withoutSlash,
      builder: (context, state) => const LandingView(),
    ),

    /// Giriş Yap Ekranı için Rota
    GoRoute(
      path: AppRouteName.login.path,
      name: AppRouteName.login.withoutSlash,
      builder: (context, state) => const LoginView(),
    ),

    /// Kaydol Ekranı için Rota
    GoRoute(
      path: AppRouteName.signup.path,
      name: AppRouteName.signup.withoutSlash,
      builder: (context, state) => const RegisterView(),
    ),

    /// Ana Sayfa için Rota
    GoRoute(
      path: AppRouteName.restaurantHome.path,
      name: AppRouteName.restaurantHome.withoutSlash,
      builder: (context, state) => const RestaurantHomePageView(),
    ),

    GoRoute(
      path: AppRouteName.addRestaurant.path,
      name: AppRouteName.addRestaurant.withoutSlash,
      builder: (context, state) => const AddRestaurantView(),
    ),

    GoRoute(
      path: AppRouteName.restaurantMenu.path,
      name: AppRouteName.restaurantMenu.withoutSlash,
      builder: (context, state) => const RestaurantMenuView(),
    ),

    GoRoute(
      path: AppRouteName.restaurantReview.path,
      name: AppRouteName.restaurantReview.withoutSlash,
      builder: (context, state) => const RestaurantReviewView(),
    ),

    GoRoute(
      path: AppRouteName.reviewReply.path,
      name: AppRouteName.reviewReply.withoutSlash,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ReviewReplyView(
          reviewId: extra['reviewId'] as String,
          comment: extra['comment'] as String,
        );
      },
    ),
  ];
}

FutureOr<String?> _routeGuard(
  BuildContext context,
  GoRouterState state,
) async {
  final storageRepository = getIt<IStorageRepository>();

  /// Uygulamanın İlk Kez Açılıp Açılmadığını Kontrol Etme
  final isFirstTimeAppOpen =
      (await storageRepository.getIsFirstTimeAppOpen()) ?? true;

  /// Kullanıcının Giriş Yapıp Yapmadığını Kontrol Etme
  final isLoggedIn = (await storageRepository.getIsLogged()) ?? false;
  log('Durumlar - isFirstTimeAppOpen: $isFirstTimeAppOpen, isLoggedIn: $isLoggedIn');
  log('Restaurant ID: ${await storageRepository.getRestaurantId()}');
  log('Refresh Token: ${await storageRepository.getRefreshToken()}');
  log('Token: ${await storageRepository.getToken()}');

  /// Kullanıcının Bulunduğu Sayfanın Yolunu Alma
  final currentLocation = state.matchedLocation;

  /// Genel Erişilebilir Sayfaların Listesini Tanımlama
  final publicPaths = <String>[
    AppRouteName.landing.path,
    AppRouteName.login.path,
    AppRouteName.signup.path,
  ];

  /// [Durum 1] Uygulama İlk Kez Açılıyorsa [isFirstTimeAppOpen == true]
  if (isFirstTimeAppOpen) {
    // Eğer kullanıcı sayfalarda değilse, onu /landing sayfasına yönlendir
    if (!publicPaths.contains(currentLocation)) {
      log("Kullanıcı ilk kez açılışta, LandingView'e yönlendiriliyor.");
      return AppRouteName.landing.path;
    } else {
      //  yönlendirme yapma
      return null;
    }
  }

  /// Buradan itibaren, [isFirstTimeAppOpen == false]
  /// [Durum 2]  Kullanıcı Giriş Yapmış ve Landing Sayfasındaysa
  if (isLoggedIn && currentLocation == AppRouteName.landing.path) {
    log("Kullanıcı giriş yapmış, LandingView'dan DashboardView'e yönlendiriliyor.");
    return AppRouteName.restaurantHome.path;
  }

  /// [Durum 3] Kullanıcı Giriş Yapmamış ve Yetkisiz Sayfada Değilse
  if (!isLoggedIn && !publicPaths.contains(currentLocation)) {
    log("Kullanıcı giriş yapmamış, LoginView'e yönlendiriliyor.");
    return AppRouteName.login.path;
  }

  /// [Durum 4]: Kullanıcı Giriş Yapmış ve Login veya Signup Sayfasındaysa
  if (isLoggedIn &&
      (currentLocation == AppRouteName.login.path ||
          currentLocation == AppRouteName.signup.path)) {
    log("Kullanıcı zaten giriş yapmış, DashboardView'e yönlendiriliyor.");
    return AppRouteName.restaurantHome.path;
  }

  /// [Varsayılan Durum] Yönlendirme yapma, mevcut sayfada kal
  return null;
}

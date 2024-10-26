enum AppStorage {
  ///
  token('token'),
  isFirstTimeAppOpen('isFirstTimeAppOpen'),
  isLoggedIn('isLoggedIn'),
  refreshToken('refreshToken'),
  restaurantId('restaurantId');

  ///
  const AppStorage(this.key);
  final String key;
}

enum AppStorage {
  ///
  token('token'),
  isFirstTimeAppOpen('isFirstTimeAppOpen'),
  isLoggedIn('isLoggedIn'),
  refreshToken('refreshToken');

  ///
  const AppStorage(this.key);
  final String key;
}

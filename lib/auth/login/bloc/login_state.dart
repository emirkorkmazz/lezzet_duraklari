part of 'login_bloc.dart';

enum LoginStatus {
  unknown, // Başlangıç durumu, oturum durumu bilinmiyor.
  authenticated, // Kullanıcı başarıyla doğrulanmış.
  unAuthenticated, // Kullanıcı doğrulanamamış.
  loading, // Oturum durumu yükleniyor.
  failure, // Oturum açma işlemi başarısız oldu.
  edit, // Kullanıcı bilgileri düzenleniyor.
}

final class LoginState extends Equatable {
  ///
  const LoginState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
    this.status = LoginStatus.unknown,
  });

  /// Form Alanlarının
  final EmailInput email;
  final PasswordInput password;

  ///
  final bool isValid;

  ///
  final LoginStatus status;

  ///
  LoginState copyWith({
    EmailInput? email,
    PasswordInput? password,
    bool? isValid,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        isValid,
        status,
      ];
}

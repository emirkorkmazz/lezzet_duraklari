part of 'register_bloc.dart';

enum RegisterStatus {
  unknown, // Başlangıç durumu, oturum durumu bilinmiyor.
  authenticated, // Kullanıcı başarıyla doğrulanmış.
  unAuthenticated, // Kullanıcı doğrulanamamış.
  loading, // Oturum durumu yükleniyor.
  failure, // Oturum açma işlemi başarısız oldu.
  edit, // Kullanıcı bilgileri düzenleniyor.
}

final class RegisterState extends Equatable {
  ///
  const RegisterState({
    this.email = const EmailInput.pure(),
    this.name = const NameInput.pure(),
    this.surname = const NameInput.pure(),
    this.phoneNumber = const PhoneNumberInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
    this.status = RegisterStatus.unknown,
    this.role = UserRole.user,
  });

  /// Form Alanlarının
  final EmailInput email;
  final NameInput name;
  final NameInput surname;
  final PhoneNumberInput phoneNumber;
  final PasswordInput password;
  final UserRole role;

  ///
  final bool isValid;

  ///
  final RegisterStatus status;

  ///
  RegisterState copyWith({
    EmailInput? email,
    NameInput? name,
    NameInput? surname,
    PhoneNumberInput? phoneNumber,
    PasswordInput? password,
    UserRole? role,
    bool? isValid,
    RegisterStatus? status,
  }) {
    return RegisterState(
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      role: role ?? this.role,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        email,
        name,
        surname,
        phoneNumber,
        password,
        role,
        isValid,
        status,
      ];
}

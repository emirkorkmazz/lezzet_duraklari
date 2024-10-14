part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class RegisterSurnameChanged extends RegisterEvent {
  const RegisterSurnameChanged(this.surname);

  final String surname;

  @override
  List<Object> get props => [surname];
}

final class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class RegisterRoleChanged extends RegisterEvent {
  const RegisterRoleChanged(this.role);

  final UserRole role;

  @override
  List<Object> get props => [role];
}

final class RegisterPhoneNumberChanged extends RegisterEvent {
  const RegisterPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted(
    this.email,
    this.name,
    this.surname,
    this.password,
    this.phoneNumber,
    this.role,
  );

  final String email;
  final String name;
  final String surname;
  final String password;
  final String phoneNumber;
  final UserRole role;
  @override
  List<Object> get props => [
        email,
        name,
        surname,
        password,
        phoneNumber,
        role,
      ];
}

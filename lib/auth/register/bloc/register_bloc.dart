import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

part 'register_event.dart';
part 'register_state.dart';

@Injectable()
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required this.authRepository,
  }) : super(const RegisterState()) {
    ///
    on<RegisterEmailChanged>(_onEmailChanged);

    ///
    on<RegisterNameChanged>(_onNameChanged);

    ///
    on<RegisterSurnameChanged>(_onSurnameChanged);

    ///
    on<RegisterRoleChanged>(_onRoleChanged);

    ///
    on<RegisterPhoneNumberChanged>(_onPhoneNumberChanged);

    ///
    on<RegisterPasswordChanged>(_onPasswordChanged);

    ///
    on<RegisterSubmitted>(_onSubmitted);
  }

  final IAuthRepository authRepository;
  FutureOr<void> _onRoleChanged(
    RegisterRoleChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        role: event.role,
        status: RegisterStatus.edit,
        isValid: Formz.validate([
          state.email,
          state.name,
          state.surname,
          state.password,
        ]),
      ),
    );
  }

  FutureOr<void> _onPhoneNumberChanged(
    RegisterPhoneNumberChanged event,
    Emitter<RegisterState> emit,
  ) {
    final phoneNumber = PhoneNumberInput.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: RegisterStatus.edit,
        isValid: Formz.validate([
          phoneNumber,
          state.email,
          state.name,
          state.surname,
          state.password,
        ]),
      ),
    );
  }

  /// [1 Email] alanı doldurulduğunda kontrol
  FutureOr<void> _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    ///
    final email = EmailInput.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        status: RegisterStatus.edit,
        isValid: Formz.validate([
          email,
          state.name,
          state.surname,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  /// [2 Name] alanı doldurulduğunda kontrol
  FutureOr<void> _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    ///
    final name = NameInput.dirty(event.name);

    emit(
      state.copyWith(
        name: name,
        status: RegisterStatus.edit,
        isValid: Formz.validate([
          state.email,
          name,
          state.surname,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  /// [3 Surname] alanı doldurulduğunda kontrol
  FutureOr<void> _onSurnameChanged(
    RegisterSurnameChanged event,
    Emitter<RegisterState> emit,
  ) {
    ///
    final surname = NameInput.dirty(event.surname);

    emit(
      state.copyWith(
        surname: surname,
        status: RegisterStatus.edit,
        isValid: Formz.validate([
          state.email,
          state.name,
          surname,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  /// [4 Password] alanı doldurulduğunda kontrol
  FutureOr<void> _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    ///
    final password = PasswordInput.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        status: RegisterStatus.edit,
        isValid: Formz.validate([
          password,
          state.email,
          state.name,
          state.surname,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    ///
    if (!state.isValid) return;
    emit(state.copyWith(status: RegisterStatus.loading));

    /// Request'i hazırlayalım
    final request = RegisterRequest(
      email: state.email.value,
      name: state.name.value,
      surname: state.surname.value,
      password: state.password.value,
      phoneNumber: state.phoneNumber.value,
      role: state.role.toStringValue,
    );

    /// Metodu çağır
    final result = await authRepository.registerUser(request: request);

    ///
    result.fold(
      /// [Handle left]: Error Type
      (AuthFailure failure) => emit(
        state.copyWith(
          status: RegisterStatus.failure,
        ),
      ),

      /// [Handle right]: Response Type
      (response) {
        return emit(
          state.copyWith(
            status: RegisterStatus.authenticated,
          ),
        );
      },
    );
  }
}

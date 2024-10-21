import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';
part 'login_event.dart';
part 'login_state.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
  }) : super(const LoginState()) {
    ///
    on<LoginEmailChanged>(_onEmailChanged);

    ///
    on<LoginPasswordChanged>(_onPasswordChanged);

    ///
    on<LoginSubmitted>(_onSubmitted);

    ///
    on<LogoutRequested>(_onLogoutRequested);
  }
  final IAuthRepository authRepository;

  /// [1 Email] alanı doldurulduğunda kontrol
  FutureOr<void> _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    ///
    final email = EmailInput.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: LoginStatus.edit,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  /// [2 Password] alanı doldurulduğunda kontrol
  FutureOr<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    ///
    final password = PasswordInput.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: LoginStatus.edit,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  FutureOr<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    ///
    if (!state.isValid) return;
    emit(state.copyWith(status: LoginStatus.loading));

    /// Request'i hazırlayalım
    final request = LoginRequest(
      email: state.email.value,
      password: state.password.value,
    );

    /// Metodu çağır
    final result = await authRepository.loginUser(request: request);

    ///
    result.fold(
      /// [Handle left]: Error Type
      (AuthFailure failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,
        ),
      ),

      /// [Handle right]: Response Type
      (response) {
        return emit(
          state.copyWith(
            status: LoginStatus.authenticated,
          ),
        );
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    ///
    final result = await authRepository.logout();

    ///
    result.fold(
      /// [Handle left]: Error Type
      (AuthFailure failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,
        ),
      ),

      /// [Handle right]: Response Type
      (unit) {
        return emit(
          state.copyWith(
            status: LoginStatus.unAuthenticated,
            email: const EmailInput.pure(),
            password: const PasswordInput.pure(),
            isValid: false,
          ),
        );
      },
    );
  }
}

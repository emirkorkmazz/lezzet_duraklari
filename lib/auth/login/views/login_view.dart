import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/auth/auth.dart';
import '/core/core.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    ///
    return GestureDetector(
      /// Dismiss the Keyboard - Klavyeyi Kapat/Gizle
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },

      ///
      child: const Scaffold(
        ///
        body: _LoginViewBody(),
      ),
    );
  }
}

class _LoginViewBody extends StatelessWidget {
  const _LoginViewBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      children: const [
        /// [1] Logo
        Logo(),
        SizedBox(height: 40),

        /// [2]
        _LoginWelcomeMessage(),
        SizedBox(height: 20),

        /// [3] Username Field
        _UsernameField(),

        /// [4] Password Field
        _PasswordField(),

        /// [5] Login Button
        _LoginButton(),
        SizedBox(height: 60),

        /// [6]
        _DontHaveAnAccount(),
      ],
    );
  }
}

class _LoginWelcomeMessage extends StatelessWidget {
  const _LoginWelcomeMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giriş Yap',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'Giriş Yap',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<LoginBloc>();
    final state = context.watch<LoginBloc>().state;

    return AppTextField(
      hintText: 'Email',
      autoFillHints: const [AutofillHints.username],
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      prefix: const Icon(
        Icons.account_circle,
      ),

      /// [Event Tetikle]
      onChanged: (email) => read.add(
        LoginEmailChanged(email),
      ),

      errorText: state.email.displayError?.errorText(context, 'Email'),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<LoginBloc>();
    final state = context.watch<LoginBloc>().state;

    return AppTextField(
      hintText: 'Parola',
      autoFillHints: const [AutofillHints.password],
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: true,
      // obscureText parametresi sebebiyle min/maxLine'a elle değer
      minLines: 1,
      maxLines: 1,
      prefix: const Icon(
        Icons.lock,
      ),

      /// [Event Tetikle]
      onChanged: (password) => read.add(
        LoginPasswordChanged(password),
      ),

      errorText: state.password.displayError?.errorText(context, 'Parola'),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final read = context.read<LoginBloc>();
    final state = context.watch<LoginBloc>().state;

    ///
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        /// Giriş Hatalı ise
        if (state.status == LoginStatus.failure) {
          final errorText = Text(
            'Hata',
            style: const TextStyle(
              color: Colors.white,
            ),
          );

          final snackBar = SnackBar(
            content: errorText,
            backgroundColor: Theme.of(context).colorScheme.error,
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }

        /// Giriş Başarılı İse
        if (state.status == LoginStatus.authenticated) {
          final successText = Text(
            'Giriş Başarılı ${state.email.value}',
            style: const TextStyle(
              color: Colors.white,
            ),
          );
          final snackBar = SnackBar(
            content: successText,
            backgroundColor: Theme.of(context).colorScheme.primary,
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          /// [Todo Sayfasına Git]
          _goTodoView(context);
        }
      },

      ///
      child: AppElevatedButton(
        ///
        onPressed: state.isValid
            ? () {
                /// Dismiss the Keyboard - Klavyeyi Kapat/Gizle
                FocusScope.of(context).unfocus();

                /// Kullanıcı Giriş İşlemi
                read.add(
                  LoginSubmitted(
                    state.email.value,
                    state.password.value,
                  ),
                );
              }

            /// isValid değilse Disable olarak göster
            : null,

        ///
        child: state.status == LoginStatus.loading ||
                state.status == LoginStatus.authenticated
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : Text(
                'Giriş Yap',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                ),
              ),
      ),
    );
  }

  void _goTodoView(BuildContext context) {
    //
    context.go(AppRouteName.restaurantHome.path);
    // Alternatif Kullanım: İsimlendirilmiş Rota
    // context.goNamed(AppRouteName.todo.withoutSlash);
  }
}

class _DontHaveAnAccount extends StatelessWidget {
  const _DontHaveAnAccount();

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      /// [Signup Sayfasına Git]
      onPressed: () => _goSignupView(context),
      primaryText: 'Hesabın yok mu?',
      actionText: 'Hesap Oluştur',
    );
  }

  void _goSignupView(BuildContext context) =>
      context.go(AppRouteName.signup.path);
}

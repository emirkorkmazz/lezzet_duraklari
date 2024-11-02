import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
//import 'package:go_router/go_router.dart';

import '/auth/auth.dart';
import '/core/core.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
        body: _RegisterViewBody(),
      ),
    );
  }
}

class _RegisterViewBody extends StatelessWidget {
  const _RegisterViewBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      children: const [
        /// [1] Logo
        Logo(),
        SizedBox(height: 20),

        /// [2]
        _RegisterWelcomeMessage(),
        SizedBox(height: 20),

        /// [3] Username Field
        _EmailField(),

        /// [4] Name Field
        _NameField(),

        /// [5] Surname Field
        _SurnameField(),

        /// [6] Phone Number Field
        _PhoneNumberField(),

        /// [6] Password Field
        _PasswordField(),

        /// [7] Role Field
        _RoleField(),

        /// [8] Login Button
        _RegisterButton(),
        SizedBox(height: 15),

        /// [89]
        _HaveAnAccountAlready(),
      ],
    );
  }
}

class _RegisterWelcomeMessage extends StatelessWidget {
  const _RegisterWelcomeMessage();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hesap Oluştur',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'Lezzet Durakları Uygulamamıza Katılın',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RegisterBloc>();
    final state = context.watch<RegisterBloc>().state;

    return AppTextField(
      hintText: 'Email',
      autoFillHints: const [AutofillHints.username],
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      prefix: const Icon(
        Icons.email_outlined,
      ),

      /// [Event Tetikle]
      onChanged: (email) => read.add(
        RegisterEmailChanged(email),
      ),

      errorText: state.email.displayError?.errorText(context, 'Email'),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RegisterBloc>();
    final state = context.watch<RegisterBloc>().state;

    return AppTextField(
      hintText: 'Adınız',
      autoFillHints: const [AutofillHints.name],
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      prefix: const Icon(
        Icons.person,
      ),

      /// [Event Tetikle]
      onChanged: (name) => read.add(
        RegisterNameChanged(name),
      ),

      errorText:
          state.name.displayError?.errorText(context, 'Geçerli bir ad giriniz'),
    );
  }
}

class _SurnameField extends StatelessWidget {
  const _SurnameField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RegisterBloc>();
    final state = context.watch<RegisterBloc>().state;

    return AppTextField(
      hintText: 'Soyadınız',
      autoFillHints: const [AutofillHints.familyName],
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      prefix: const Icon(
        Icons.person_outline,
      ),

      /// [Event Tetikle]
      onChanged: (surname) => read.add(
        RegisterSurnameChanged(surname),
      ),

      errorText: state.surname.displayError
          ?.errorText(context, 'Geçerli bir soyadı giriniz'),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RegisterBloc>();
    final state = context.watch<RegisterBloc>().state;

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
        RegisterPasswordChanged(password),
      ),

      errorText: state.password.displayError?.errorText(context, 'Parola'),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RegisterBloc>();
    final state = context.watch<RegisterBloc>().state;

    return AppTextField(
      hintText: 'Telefon Numaranız',
      autoFillHints: const [AutofillHints.telephoneNumber],
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      prefix: const Icon(
        Icons.phone,
      ),
      onChanged: (phoneNumber) => read.add(
        RegisterPhoneNumberChanged(phoneNumber),
      ),
      errorText: state.phoneNumber.displayError
          ?.errorText(context, 'Geçerli bir telefon numarası giriniz'),
    );
  }
}

class _RoleField extends StatelessWidget {
  const _RoleField();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RegisterBloc>();
    final state = context.watch<RegisterBloc>().state;

    return Row(
      children: [
        Expanded(
          child: RadioListTile<UserRole>(
            title: const Text('Kullanıcı'),
            value: UserRole.user,
            groupValue: state.role,
            onChanged: (UserRole? value) {
              if (value != null) {
                read.add(RegisterRoleChanged(value));
              }
            },
          ),
        ),
        Expanded(
          child: RadioListTile<UserRole>(
            title: const Text('İşletme Sahibi'),
            value: UserRole.businessOwner,
            groupValue: state.role,
            onChanged: (UserRole? value) {
              if (value != null) {
                read.add(RegisterRoleChanged(value));
              }
            },
          ),
        ),
      ],
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    final read = context.read<RegisterBloc>();
    final state = context.watch<RegisterBloc>().state;

    ///
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        /// Giriş Hatalı ise
        if (state.status == RegisterStatus.failure) {
          final errorText = const Text(
            'Hesap Oluşturma Hatası',
            style: TextStyle(
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

        ///
        if (state.status == RegisterStatus.authenticated) {
          final successText = const Text(
            'Hesap Oluşturma Başarılı',
            style: TextStyle(
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

          /// [Login Sayfasına Git]
          _goLoginView(context);
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
                  RegisterSubmitted(
                    state.email.value,
                    state.name.value,
                    state.surname.value,
                    state.password.value,
                    state.phoneNumber.value,
                    state.role,
                  ),
                );
              }

            /// isValid değilse Disable olarak göster
            : null,

        ///
        child: state.status == RegisterStatus.loading ||
                state.status == RegisterStatus.authenticated
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : Text(
                'Hesap Oluştur',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                ),
              ),
      ),
    );
  }

  void _goLoginView(BuildContext context) =>
      context.go(AppRouteName.login.path);
}

class _HaveAnAccountAlready extends StatelessWidget {
  const _HaveAnAccountAlready();

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      /// [Login Sayfasına Git]

      onPressed: () => _goLoginView(context),

      primaryText: 'Hesabın var mı?',
      actionText: 'Giriş Yap',
    );
  }

  // [28. Adım]
  void _goLoginView(BuildContext context) =>
      context.go(AppRouteName.login.path);
}

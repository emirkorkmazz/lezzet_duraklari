import 'package:flutter/material.dart';
import '/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/auth/auth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => getIt<RegisterBloc>(),
        )
      ],
      child: MaterialApp.router(
        /// [Router]
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}

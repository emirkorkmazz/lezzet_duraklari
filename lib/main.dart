import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lezzet_duraklari/app.dart';
import '/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await configureDependencies();

  runApp(const App());
}

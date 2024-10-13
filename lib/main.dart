import 'package:flutter/material.dart';
import 'package:lezzet_duraklari/app.dart';
import '/core/di/injection.dart';

void main() async {
  await configureDependencies();

  runApp(const App());
}

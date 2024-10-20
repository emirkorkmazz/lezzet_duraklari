import 'package:flutter/material.dart';

@immutable
final class AppTheme {
  const AppTheme._();

  /// [1] [Açık Tema]
  static final lightTheme = ThemeData(
    colorScheme: lightScheme,
  );

  /// [2] [Koyu Tema]
  static final darkTheme = ThemeData(
    colorScheme: darkScheme,
  );

  /// Material Design 3 Konseptine Uygun Özel Color Scheme Oluşturduk
  static ColorScheme get lightScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(4283196971),
        surfaceTint: Color(4283196971),
        onPrimary: Color(4294967295),
        primaryContainer: Color(4291751331),
        onPrimaryContainer: Color(4279312384),
        secondary: Color(4283982409),
        onSecondary: Color(4294967295),
        secondaryContainer: Color(4292667335),
        onSecondaryContainer: Color(4279639563),
        tertiary: Color(4281886306),
        onTertiary: Color(4294967295),
        tertiaryContainer: Color(4290571495),
        onTertiaryContainer: Color(4278198302),
        error: Color(4290386458),
        onError: Color(4294967295),
        errorContainer: Color(4294957782),
        onErrorContainer: Color(4282449922),
        surface: Color(4294572783),
        onSurface: Color(4279901206),
        onSurfaceVariant: Color(4282665021),
        outline: Color(4285888876),
        outlineVariant: Color(4291152057),
        shadow: Color(4278190080),
        scrim: Color(4278190080),
        inverseSurface: Color(4281282858),
        inversePrimary: Color(4289909129),
        primaryFixed: Color(4291751331),
        onPrimaryFixed: Color(4279312384),
        primaryFixedDim: Color(4289909129),
        onPrimaryFixedVariant: Color(4281749013),
        secondaryFixed: Color(4292667335),
        onSecondaryFixed: Color(4279639563),
        secondaryFixedDim: Color(4290825132),
        onSecondaryFixedVariant: Color(4282403379),
        tertiaryFixed: Color(4290571495),
        onTertiaryFixed: Color(4278198302),
        tertiaryFixedDim: Color(4288729291),
        onTertiaryFixedVariant: Color(4280241739),
        surfaceDim: Color(4292533200),
        surfaceBright: Color(4294572783),
        surfaceContainerLowest: Color(4294967295),
        surfaceContainerLow: Color(4294243561),
        surfaceContainer: Color(4293849059),
        surfaceContainerHigh: Color(0xffe6f6ff),
        surfaceContainerHighest: Color(0xffb3e4ff),
      );

  /// Material Design 3 Konseptine Uygun Özel Color Scheme Oluşturduk
  static ColorScheme get darkScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(4289909129),
        surfaceTint: Color(4289909129),
        onPrimary: Color(4280301056),
        primaryContainer: Color(4281749013),
        onPrimaryContainer: Color(4291751331),
        secondary: Color(4290825132),
        onSecondary: Color(4280955678),
        secondaryContainer: Color(4282403379),
        onSecondaryContainer: Color(4292667335),
        tertiary: Color(4288729291),
        onTertiary: Color(4278204212),
        tertiaryContainer: Color(4280241739),
        onTertiaryContainer: Color(4290571495),
        error: Color(4294948011),
        onError: Color(4285071365),
        errorContainer: Color(4287823882),
        onErrorContainer: Color(4294957782),
        surface: Color(4279374862),
        onSurface: Color(4293059544),
        onSurfaceVariant: Color(4291152057),
        outline: Color(4287599237),
        outlineVariant: Color(4282665021),
        shadow: Color(4278190080),
        scrim: Color(4278190080),
        inverseSurface: Color(4293059544),
        inversePrimary: Color(4283196971),
        primaryFixed: Color(4291751331),
        onPrimaryFixed: Color(4279312384),
        primaryFixedDim: Color(4289909129),
        onPrimaryFixedVariant: Color(4281749013),
        secondaryFixed: Color(4292667335),
        onSecondaryFixed: Color(4279639563),
        secondaryFixedDim: Color(4290825132),
        onSecondaryFixedVariant: Color(4282403379),
        tertiaryFixed: Color(4290571495),
        onTertiaryFixed: Color(4278198302),
        tertiaryFixedDim: Color(4288729291),
        onTertiaryFixedVariant: Color(4280241739),
        surfaceDim: Color(4279374862),
        surfaceBright: Color(4281874994),
        surfaceContainerLowest: Color(4279045897),
        surfaceContainerLow: Color(4279901206),
        surfaceContainer: Color(4280164378),
        surfaceContainerHigh: Color(4280822564),
        surfaceContainerHighest: Color(4281546286),
      );
}
import 'package:flutter/material.dart';

class AppColors {
  static Color seedColor = Colors.green.shade900;

  static const Color primary = Color(0xFF286c2a);

  static const Color grey = Color(0xFFE0E0E0);
  static const Color lightGrey = Color(0xFFFAFAFA);
  static const Color darkGrey = Color(0xFF9E9E9E);

  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  );

  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  );
}

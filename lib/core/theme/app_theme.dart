import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: AppTextTheme.textTheme,
    useMaterial3: true,
    visualDensity: VisualDensity.compact,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: AppTextTheme.textTheme,
    useMaterial3: true,
    visualDensity: VisualDensity.compact,
  );
}

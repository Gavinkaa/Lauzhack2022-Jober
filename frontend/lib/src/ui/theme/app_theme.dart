import 'package:flutter/material.dart';
import 'package:jober/src/ui/theme/app_colors.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[
        const AppColors(
          bottomAppBarColor: Colors.blue,
          bottomAppBarIconColor: Colors.white,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jober/src/ui/theme/app_colors.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[
        const AppColors(
          bottomAppBarColor: Color(0xFF4E9EA0),
          bottomAppBarIconColor: Colors.white,
          primaryColor: Color(0xFF4E9EA0),
          secondaryColor: Color(0xFFDB653B),
          primaryLightColor: Color(0xFFE5F2F2),
          secondaryLightColor: Color(0xFFFFF0E5),
        ),
      ],

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFF4E9EA0),
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFE5F2F2),
          iconColor: Color(0xFF4E9EA0),
          prefixIconColor: Color(0xFF4E9EA0),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        )
    );
  }
}

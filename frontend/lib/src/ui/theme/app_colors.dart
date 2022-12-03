import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? bottomAppBarColor;
  final Color? bottomAppBarIconColor;

  const AppColors({
    this.bottomAppBarColor,
    this.bottomAppBarIconColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({Color? bottomAppBarColor, Color? bottomAppBarIconColor}) {
    return AppColors(
      bottomAppBarColor: bottomAppBarColor ?? this.bottomAppBarColor,
      bottomAppBarIconColor: bottomAppBarIconColor ?? this.bottomAppBarIconColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      bottomAppBarColor: Color.lerp(bottomAppBarColor, other.bottomAppBarColor, t),
      bottomAppBarIconColor: Color.lerp(bottomAppBarIconColor, other.bottomAppBarIconColor, t),
    );
  }

}

import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? bottomAppBarColor;
  final Color? bottomAppBarIconColor;
  final Color? primaryColor;
  final Color? primaryLightColor;
  final Color? secondaryColor;
  final Color? secondaryLightColor;


  const AppColors({
    this.bottomAppBarColor,
    this.bottomAppBarIconColor,
    this.primaryColor,
    this.secondaryColor,
    this.primaryLightColor,
    this.secondaryLightColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? bottomAppBarColor,
    Color? bottomAppBarIconColor,
    Color? primaryColor,
    Color? primaryLightColor,
    Color? secondaryColor,
    Color? secondaryLightColor,
  }) {
    return AppColors(
      bottomAppBarColor: bottomAppBarColor ?? this.bottomAppBarColor,
      bottomAppBarIconColor: bottomAppBarIconColor ?? this.bottomAppBarIconColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryLightColor: primaryLightColor ?? this.primaryLightColor,
      secondaryLightColor: secondaryLightColor ?? this.secondaryLightColor,
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
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      primaryLightColor: Color.lerp(primaryLightColor, other.primaryLightColor, t),
      secondaryLightColor: Color.lerp(secondaryLightColor, other.secondaryLightColor, t),
    );
  }

}

import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';

extension BoxDecorationEx on BoxDecoration {
  static BoxDecoration gradientEffect({
    List<Color>? gradientColors,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius,
      gradient: LinearGradient(
          colors: gradientColors ?? [AppColors.light_1, AppColors.light_1]),
    );
  }

  static BoxDecoration shadowEffect({
    Color? backgroundColor,
    Color? shadowColor,
    Offset? shadowOffset,
    BorderRadiusGeometry? borderRadius,
    double shadowRadius = 10,
    double blurRadius = 8,
  }) {
    return BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor ?? AppColors.lightest,
        boxShadow: [
          BoxShadow(
              color: shadowColor ?? AppColors.dark_3.withOpacity(0.1),
              blurRadius: blurRadius,
              spreadRadius: shadowRadius,
              offset: shadowOffset ?? const Offset(0, 0))
        ]);
  }
}

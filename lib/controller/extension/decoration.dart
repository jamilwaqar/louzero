import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';

extension BoxDecorationEx on BoxDecoration {
  static BoxDecoration gradientEffect({
    List<Color>? gradientColors,
    BorderRadius? border,
    double borderRadius = 0,
  }) {
    return BoxDecoration(
      borderRadius: border ?? BorderRadius.all(Radius.circular(borderRadius)),
      gradient: LinearGradient(
          colors: gradientColors ?? [AppColors.light_1, AppColors.light_1]),
    );
  }

  static BoxDecoration gradientOnlyBottomEffect({
    List<Color>? gradientColors,
    double borderRadius = 12,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      ),
      gradient: LinearGradient(
          colors: gradientColors ?? [AppColors.light_1, AppColors.light_1]),
    );
  }

  static BoxDecoration shadowEffect({
    Color? backgroundColor,
    Color? shadowColor,
    Offset? shadowOffset,
    double borderRadius = 14,
    double shadowRadius = 10,
    double blurRadius = 8,
    bool onlyTop = false,
    bool onlyBottom = false,
  }) {
    return BoxDecoration(
        borderRadius: onlyTop
            ? BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          topLeft: Radius.circular(borderRadius),
        )
            : (onlyBottom
            ? BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        )
            : BorderRadius.all(Radius.circular(borderRadius))),
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

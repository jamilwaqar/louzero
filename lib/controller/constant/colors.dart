import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color dark_1 = Color(0xFF515761);
  static const Color dark_2 = Color(0xFF3A3E45);
  static Color dark_3 = const Color(0xFF23252A);
  static Color medium_1 = const Color(0xFF9EA3AE);
  static Color medium_2 = const Color(0xFF828997);
  static Color medium_3 = const Color(0xFF686F7D);
  static Color light_1 = const Color(0xFFF1F2F4);
  static Color light_2 = const Color(0xFFD6D8DC);
  static Color light_3 = const Color(0xFFBABDC5);
  static Color lightest = const Color(0xFFFFFFFF);
  static Color darkest = const Color(0xFF0B0C0E);
  static Color icon = const Color(0xFF323232);
  static Color black = Colors.black;
}

abstract class TextStyles {
  static const TextStyle text10 = TextStyle(
      color: AppColors.dark_2, fontSize: 10, fontWeight: FontWeight.w400);

  static const TextStyle text16 = TextStyle(
      color: AppColors.dark_1, fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle title24 = TextStyle(
      color: AppColors.dark_2, fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle nav20 = TextStyle(
      color: AppColors.dark_1, fontSize: 20, fontWeight: FontWeight.w500);
}
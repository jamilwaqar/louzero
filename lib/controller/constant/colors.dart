import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color dark_1 = Color(0xFF515761);
  static const Color dark_2 = Color(0xFF3A3E45);
  static const Color dark_3 = Color(0xFF23252A);
  static const Color darkest = Color(0xFF0B0C0E);

  static const Color medium_1 = Color(0xFF9EA3AE);
  static const Color medium_2 = Color(0xFF828997);
  static const Color medium_3 = Color(0xFF686F7D);

  static const Color lightest = Color(0xFFFFFFFF);
  static const Color light_1 = Color(0xFFF1F2F4);
  static const Color light_2 = Color(0xFFD6D8DC);
  static const Color light_3 = Color(0xFFBABDC5);
  static const Color light_4 = Color(0xFFE2E2E3);

  static const Color icon = Color(0xFF323232);
  static const Color black = Colors.black;
}

abstract class TextStyles {
  static const TextStyle displayL = TextStyle(color: AppColors.dark_1, fontSize: 57);
  static const TextStyle displayM = TextStyle(color: AppColors.dark_1, fontSize: 45);
  static const TextStyle displayS = TextStyle(color: AppColors.dark_1, fontSize: 36);

  static const TextStyle headLineL = TextStyle(color: AppColors.dark_1, fontSize: 32);
  static const TextStyle headLineM = TextStyle(color: AppColors.dark_1, fontSize: 28);
  static const TextStyle headLineS = TextStyle(color: AppColors.dark_1, fontSize: 24);

  static const TextStyle titleL = TextStyle(color: AppColors.dark_1, fontSize: 22, fontWeight: FontWeight.w500);
  static const TextStyle titleM = TextStyle(color: AppColors.dark_1, fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle titleS = TextStyle(color: AppColors.dark_1, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle labelL = TextStyle(color: AppColors.dark_1, fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle labelM = TextStyle(color: AppColors.dark_1, fontSize: 12, fontWeight: FontWeight.w500);
  static const TextStyle labelS = TextStyle(color: AppColors.dark_1, fontSize: 11, fontWeight: FontWeight.w500);

  static const TextStyle bodyL = TextStyle(color: AppColors.dark_1, fontSize: 16);
  static const TextStyle bodyM = TextStyle(color: AppColors.dark_1, fontSize: 16);
  static const TextStyle bodyS = TextStyle(color: AppColors.dark_1, fontSize: 16);
}
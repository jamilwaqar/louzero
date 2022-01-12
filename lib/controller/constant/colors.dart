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

  static const Color orange = Color(0xFFEC6A3A);
  static const Color appBar = Color(0xFF263842);
  static const Color accent_1 = Color(0xFF65D19D);
  static const Color primary_1 = Color(0xFFE77C33);
  static const Color primary_50 = Color(0xFFCE6620);
  static const Color primary_60 = Color(0xFFE77C33);
  static const Color primary_80 = Color(0xFFF6C096);
  static const Color primary_95 = Color(0xFFFDEFE6);
  static const Color secondary_20 = Color(0xFF37474F);
  static const Color secondary_30 = Color(0xFF455A64);
  static const Color secondary_40 = Color(0xFF546E7A);
  static const Color secondary_60 = Color(0xFF78909C);
  static const Color secondary_70 = Color(0xFF90A4AE);
  static const Color secondary_80 = Color(0xFFB0BEC5);
  static const Color secondary_90 = Color(0xFFCFD8DC);
  static const Color secondary_95 = Color(0xFFECEFF1);
  static const Color secondary_99 = Color(0xFFF1F3F5);
  static const Color secondary_100 = Color(0xFFF6F8FA);
  static const Color error_60 = Color(0xFFE46962);

  static const Color icon = Color(0xFF323232);
  static const Color black = Colors.black;

  static const Color oddItemColor = Color(0xFFF1F2F4);
  static const Color evenItemColor = Color(0xFFF8F9FB);
}

abstract class AppStyles {
  static const bodyLarge = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const headerSmall = TextStyle(
    fontFamily: 'Barlow',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const headerRegular = TextStyle(
    fontFamily: 'Barlow',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary_20,
  );
  static const headerSmallCaps = TextStyle(
    fontFamily: 'Barlow',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary_30,
  );
  static const headerAppBar = TextStyle(
    fontFamily: 'Barlow',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.lightest,
  );
  static const headerDialog = TextStyle(
    fontFamily: 'Barlow',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary_30,
  );
  static const labelRegular = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary_20,
  );
  static const labelBold = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
}

abstract class TextStyles {
  static const TextStyle displayL =
      TextStyle(color: AppColors.dark_1, fontSize: 57);
  static const TextStyle displayM =
      TextStyle(color: AppColors.dark_1, fontSize: 45);
  static const TextStyle displayS =
      TextStyle(color: AppColors.dark_1, fontSize: 36);

  static const TextStyle headLineL =
      TextStyle(color: AppColors.dark_1, fontSize: 32);
  static const TextStyle headLineM =
      TextStyle(color: AppColors.dark_1, fontSize: 28);
  static const TextStyle headLineS =
      TextStyle(color: AppColors.dark_1, fontSize: 24);

  static const TextStyle titleL = TextStyle(
      color: AppColors.dark_1, fontSize: 22, fontWeight: FontWeight.w500);
  static const TextStyle titleM = TextStyle(
      color: AppColors.dark_1, fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle titleS = TextStyle(
      color: AppColors.dark_1, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle labelL = TextStyle(
      color: AppColors.dark_1, fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle labelM = TextStyle(
      color: AppColors.dark_1, fontSize: 12, fontWeight: FontWeight.w500);
  static const TextStyle labelS = TextStyle(
      color: AppColors.dark_1, fontSize: 11, fontWeight: FontWeight.w500);

  static const TextStyle bodyL =
      TextStyle(color: AppColors.dark_1, fontSize: 16);
  static const TextStyle bodyM =
      TextStyle(color: AppColors.dark_1, fontSize: 16);
  static const TextStyle bodyS =
      TextStyle(color: AppColors.dark_1, fontSize: 16);
}

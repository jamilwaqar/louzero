import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_text_link.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextHelpLink extends StatelessWidget {
  const AppTextHelpLink({
    Key? key,
    required this.label,
    required this.linkText,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final String linkText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.dark_1,
          ),
        ),
        AppTextLink(
          linkText,
          fontWeight: FontWeight.w600,
          textDecoration: TextDecoration.underline,
          onPressed: onPressed,
        ),
      ],
    );
  }
}

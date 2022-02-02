import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextLink extends StatelessWidget {
  const AppTextLink(
    this.text, {
    Key? key,
    this.textColor = AppColors.primary_40,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final Color textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Text(text, style: AppStyles.labelBold.copyWith(color: textColor)),
    );
  }
}

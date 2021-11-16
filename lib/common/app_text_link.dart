import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextLink extends StatelessWidget {
  const AppTextLink(this.text,
      {Key? key,
      this.textColor,
      this.fontSize = 16,
      this.fontWeight,
      this.padding = EdgeInsets.zero,
      this.textDecoration,
      this.onPressed})
      : super(key: key);
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final TextDecoration? textDecoration;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: fontSize,
            color: textColor ?? AppColors.dark_1,
            decoration: textDecoration),
      ),
    );
  }
}

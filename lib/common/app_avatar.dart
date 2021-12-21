import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppAvatar extends StatelessWidget {
  final String? path;
  final String? text;
  final Color? borderColor;
  final Color? backgroundColor;
  final double size;
  const AppAvatar(
      {Key? key,
      this.path,
      this.borderColor,
      this.backgroundColor,
      this.text = '',
      this.size = 96})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      padding: borderColor == null
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(999),
          color: backgroundColor ?? Colors.transparent),
      child: path == null
          ? Text(
              text!,
              style: TextStyle(
                color: AppColors.lightest,
                fontWeight: FontWeight.w500,
                fontSize: size / 2.2,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: Image.asset(
                path!,
              ),
            ),
    );
  }
}

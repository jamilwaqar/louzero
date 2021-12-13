import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppAvatar extends StatelessWidget {
  final String? path;
  final String? text;
  final double size;
  const AppAvatar({Key? key, this.path, this.text = '', this.size = 96})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999), color: AppColors.medium_2),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppButton extends StatelessWidget {
  AppButton({
    Key? key,
    this.label = 'button',
    this.onPressed,
    this.icon,
    this.primary = true,
    this.mb = 0,
    this.mt = 0,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool primary;
  final double mt;
  final double mb;

  final BoxDecoration secondaryBox = BoxDecoration(
      color: AppColors.light_1,
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: AppColors.medium_1, width: 1));

  final BoxDecoration primaryBox = BoxDecoration(
      color: AppColors.black, borderRadius: BorderRadius.circular(28));

  final TextStyle primaryText = const TextStyle(
    color: AppColors.lightest,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  final TextStyle secondaryText = const TextStyle(
    color: AppColors.dark_1,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed ?? () => {},
      child: Container(
        height: 56,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: mt, bottom: mb),
        decoration: primary ? primaryBox : secondaryBox,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null ? true : false,
              child: Icon(
                icon,
                color: AppColors.light_2,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(label, style: primary ? primaryText : secondaryText),
          ],
        ),
      ),
    );
  }
}

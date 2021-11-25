import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.label = 'button',
    this.onPressed,
    this.radius = 999,
    this.icon,
    this.primary = true,
    this.color = AppColors.dark_3,
    this.colorText = AppColors.lightest,
    // Spacing props:
    this.mb = 0, // margin bottom
    this.mt = 0, // margin top
    this.ml = 0, // margin left
    this.mr = 0, // margin right
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool primary;
  final Color color;
  final Color colorText;
  final double radius;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    var fg = primary ? colorText : color;
    var bg = primary ? color : AppColors.lightest;
    var bd = primary ? color : color;
    const textStyle = TextStyle(
        fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 16);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: mt,
        bottom: mb,
        left: ml,
        right: mr,
      ),
      child: FloatingActionButton.extended(
        foregroundColor: fg,
        backgroundColor: bg,
        icon: icon != null ? Icon(icon) : null,
        elevation: 0,
        extendedTextStyle: textStyle,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: bd, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        onPressed: onPressed,
        label: Text(label),
      ),
    );
  }
}

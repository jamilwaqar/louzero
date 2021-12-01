import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.label = 'button',
    this.onPressed,
    this.fontSize,
    this.width,
    this.radius = 999,
    this.icon,
    this.primary = true,
    this.wide = false,
    this.textOnly = false,
    this.color = AppColors.dark_3,
    this.colorText = AppColors.lightest,
    this.height = 40,
    this.mb = 0, // margin bottom
    this.mt = 0, // margin top
    this.ml = 0, // margin left
    this.mr = 0, // margin right
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final double? fontSize;
  final IconData? icon;
  final double? width;
  final bool wide;
  final bool primary;
  final bool textOnly;
  final Color color;
  final Color colorText;
  final double radius;
  final double height;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    var fg = primary ? colorText : color;
    var bg = primary ? color : AppColors.lightest;
    var bd = primary ? color : color;
    var iconSize = height / 1.5;
    var textSize = fontSize ?? height / 2.5;
    var textStyle = TextStyle(
        fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: textSize);

    if (textOnly) {
      bg = Colors.transparent;
      bd = Colors.transparent;
      fg = color;
    }

    return Container(
      height: height,
      width: wide ? double.infinity : width ?? null,
      margin: EdgeInsets.only(
        top: mt,
        bottom: mb,
        left: ml,
        right: mr,
      ),
      child: FloatingActionButton.extended(
        foregroundColor: fg,
        backgroundColor: bg,
        icon: icon != null ? Icon(icon, size: iconSize) : null,
        elevation: 0,
        extendedPadding: const EdgeInsetsDirectional.only(
          start: 24,
          end: 24,
        ),
        extendedTextStyle: textStyle,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: bd, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        onPressed: onPressed,
        label: Text(
          label,
        ),
      ),
    );
  }
}

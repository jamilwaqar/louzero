import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.label = 'button',
    this.onPressed,
    this.fontSize = 14,
    this.width,
    this.radius = 999,
    this.icon,
    this.primary = true,
    this.wide = false,
    this.textOnly = false,
    this.alignLeft = false,
    this.isMenu = false,
    this.color = AppColors.dark_3,
    this.colorText = AppColors.lightest,
    this.borderColor,
    this.colorIcon,
    this.height = 40,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final double fontSize;
  final IconData? icon;
  final double? width;
  final bool wide;
  final bool primary;
  final bool textOnly;
  final bool isMenu;
  final bool alignLeft;
  final Color color;
  final Color colorText;
  final Color? colorIcon;
  final Color? borderColor;
  final double radius;
  final double height;

  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    var fg = primary ? colorText : color;
    var bg = primary ? color : AppColors.lightest;
    var textStyle = TextStyle(
        fontFamily: 'Lato', fontWeight: FontWeight.w900, fontSize: fontSize);

    return Container(
      width: wide ? double.infinity : width,
      height: 40,
      margin: margin,
      child: FloatingActionButton.extended(
        heroTag: null,
        foregroundColor: fg,
        backgroundColor: bg,
        icon: icon != null
            ? Icon(
                icon,
                size: fontSize * 1.2,
                color: colorIcon,
              )
            : null,
        elevation: 0,
        extendedPadding: EdgeInsetsDirectional.only(
          start: fontSize,
          end: isMenu ? fontSize : fontSize + 8,
        ),
        extendedTextStyle: textStyle,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: borderColor ?? Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        onPressed: onPressed,
        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
            ),
            if (isMenu) SizedBox(width: 8),
            if (isMenu)
              Icon(
                Icons.arrow_drop_down,
                color: colorText,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class AppButtons extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;
  final double fontSize;
  final Color colorBackground;
  final Color colorText;
  final Color colorBorder;
  final Color colorIcon;
  final bool isMenu;

  const AppButtons({
    Key? key,
    this.onPressed,
    this.fontSize = 16,
    this.icon = MdiIcons.briefcase,
    this.colorBackground = AppColors.secondary_20,
    this.colorIcon = AppColors.accent_1,
    this.colorBorder = AppColors.orange,
    this.colorText = AppColors.secondary_20,
    this.isMenu = false,
    this.label = 'New',
  }) : super(key: key);

  const AppButtons.appBar({
    Key? key,
    this.onPressed,
    this.fontSize = 14,
    this.icon = MdiIcons.calculator,
    this.colorBackground = AppColors.secondary_20,
    this.colorIcon = AppColors.accent_1,
    this.colorBorder = Colors.transparent,
    this.colorText = AppColors.secondary_99,
    this.label = 'New',
    this.isMenu = false,
  }) : super(key: key);

  const AppButtons.iconOutline(
    this.label, {
    Key? key,
    this.onPressed,
    this.fontSize = 14,
    this.icon = Icons.add_circle,
    this.colorBackground = Colors.white,
    this.colorIcon = AppColors.orange,
    this.colorBorder = AppColors.secondary_70,
    this.colorText = AppColors.secondary_20,
    this.isMenu = false,
  }) : super(key: key);

  const AppButtons.iconFlat(
    this.label, {
    Key? key,
    this.onPressed,
    this.fontSize = 14,
    this.icon = Icons.add_circle,
    this.colorBackground = AppColors.secondary_99,
    this.colorIcon = AppColors.orange,
    this.colorBorder = Colors.transparent,
    this.colorText = AppColors.secondary_20,
    this.isMenu = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      isMenu: isMenu,
      height: fontSize * 2,
      fontSize: fontSize,
      label: label,
      icon: icon,
      borderColor: colorBorder,
      colorText: colorText,
      color: colorBackground,
      colorIcon: colorIcon,
      onPressed: onPressed,
    );
  }
}

class AppBarButtonAdd extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;

  const AppBarButtonAdd({Key? key, this.onPressed, this.label = 'New'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      fontSize: 16,
      label: label!,
      icon: Icons.add_circle,
      color: AppColors.secondary_20,
      colorIcon: AppColors.accent_1,
      onPressed: onPressed,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.label = 'button',
    this.onPressed,
    this.fontSize = 14,
    this.padX = 16,
    this.width,
    this.radius = 999,
    this.icon,
    this.primary = true,
    this.wide = false,
    this.textOnly = false,
    this.alignLeft = false,
    this.isMenu = false,
    this.colorBg = AppColors.secondary_20,
    this.colorText = AppColors.lightest,
    this.borderColor,
    this.colorIcon,
    this.height = 40,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final double fontSize;
  final double padX;
  final IconData? icon;
  final double? width;
  final bool wide;
  final bool primary;
  final bool textOnly;
  final bool isMenu;
  final bool alignLeft;
  final Color colorBg;
  final Color colorText;
  final Color? colorIcon;
  final Color? borderColor;
  final double radius;
  final double height;

  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    var fg = primary ? colorText : colorBg;
    var bg = primary ? colorBg : AppColors.lightest;
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
                size: fontSize * 1.3,
                color: colorIcon,
              )
            : null,
        extendedIconLabelSpacing: 5,
        elevation: 0,
        extendedPadding: EdgeInsetsDirectional.only(
          start: isMenu ? 16 : padX,
          end: isMenu ? 16 : padX,
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
            Text(label, style: AppStyles.labelBold),
            if (isMenu) const SizedBox(width: 8),
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
      colorBg: colorBackground,
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
      colorBg: AppColors.secondary_20,
      colorIcon: AppColors.accent_1,
      onPressed: onPressed,
    );
  }
}

class AppButtonGradient extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double height;
  final IconData? iconLeading;
  final IconData? iconTrailing;
  final Color colorText;
  final Color? colorBg;
  final Color? colorBd;
  final Color colorIconLeading;
  final Color colorIconTrailing;
  final List<Color>? colors;

  const AppButtonGradient({
    Key? key,
    this.label = "Button",
    this.onPressed,
    this.iconLeading,
    this.iconTrailing,
    this.colorBg,
    this.colorBd,
    this.colors,
    this.colorText = Colors.white,
    this.colorIconLeading = Colors.white,
    this.colorIconTrailing = Colors.white,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _from = colorBg ?? const Color(0xFFEC5B2A);
    Color _to = colorBg ?? const Color(0xFFEB7649);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        child: Ink(
          decoration: BoxDecoration(
              border: Border.all(color: colorBd ?? Colors.transparent),
              gradient: LinearGradient(
                colors: colors ?? [_from, _to],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  width: iconLeading != null ? 40 : 20,
                  padding: const EdgeInsets.only(right: 5),
                  alignment: const Alignment(1, 0),
                  child: iconLeading != null
                      ? Icon(iconLeading, color: colorIconLeading, size: 20)
                      : null,
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppStyles.labelBold
                      .copyWith(color: colorText, fontWeight: FontWeight.w700),
                ),
                Container(
                  width: iconTrailing != null ? 40 : 20,
                  padding: const EdgeInsets.only(left: 5),
                  alignment: const Alignment(-1, 0),
                  child: iconTrailing != null
                      ? Icon(iconLeading, color: colorIconTrailing, size: 20)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

abstract class Buttons {
  static Widget lock(String label, {VoidCallback? onPressed}) {
    return AppButtonGradient(
      label: label,
      onPressed: onPressed,
      colorBg: Colors.transparent,
      colorBd: AppColors.secondary_70,
      colorText: AppColors.secondary_20,
      iconLeading: Icons.lock,
      colorIconLeading: AppColors.orange,
    );
  }

  static Widget outline(String label,
      {VoidCallback? onPressed, IconData? icon}) {
    return AppButtonGradient(
      label: label,
      onPressed: onPressed,
      colorBg: Colors.transparent,
      colorBd: AppColors.secondary_70,
      colorText: AppColors.secondary_20,
      iconLeading: icon,
      colorIconLeading: AppColors.orange,
    );
  }

  static Widget flat(String label, {VoidCallback? onPressed, IconData? icon}) {
    return AppButtonGradient(
      label: label,
      onPressed: onPressed,
      colorBg: AppColors.secondary_99,
      colorText: AppColors.secondary_20,
      iconLeading: icon,
      colorIconLeading: AppColors.orange,
    );
  }

  static Widget submit(String label, {VoidCallback? onPressed}) {
    return AppButtonGradient(
      label: label,
      onPressed: onPressed,
      colorBg: AppColors.secondary_20,
    );
  }

  static Widget text(String label, {VoidCallback? onPressed}) {
    return AppButtonGradient(
      label: label,
      onPressed: onPressed,
      colorBg: Colors.transparent,
      colorText: AppColors.secondary_20,
    );
  }

  static Widget appBar(String label,
      {VoidCallback? onPressed, IconData? icon}) {
    return AppButtonGradient(
      label: label,
      iconLeading: icon,
      onPressed: onPressed,
      colorIconLeading: AppColors.accent_1,
      colorText: AppColors.secondary_99,
      colorBg: AppColors.secondary_20,
    );
  }
}

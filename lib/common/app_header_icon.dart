import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'app_icon_button.dart';

class AppHeaderIcon extends StatelessWidget {
  final IconData? icon;
  final IconData? iconStart;
  final String title;
  final TextStyle style;
  final double mt;
  final double mb;
  final double sizeIcon;
  final VoidCallback? onTap;
  const AppHeaderIcon(
    this.title, {
    this.icon,
    this.iconStart,
    this.style = AppStyles.headerRegular,
    this.mb = 8,
    this.mt = 0,
    this.sizeIcon = 24,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: mb, top: mt),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          if (iconStart != null)
            Icon(
              iconStart,
              color: AppColors.secondary_60,
              size: sizeIcon,
            ),
          if (iconStart != null) const SizedBox(width: 8),
          Text(
            title,
            style: style,
          ),
          if (icon != null)
            AppIconButton(
              pl: 8,
              size: sizeIcon,
              iconSize: sizeIcon / 1.6,
              icon: icon!,
              onTap: onTap,
            ),
        ],
      ),
    );
  }
}

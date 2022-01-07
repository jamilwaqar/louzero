import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../app_icon_button.dart';

class TextKeyValIcon extends StatelessWidget {
  final String kkey;
  final String val;
  final IconData icon;
  final Color colorIcon;
  final Color colorBg;
  final Color color;
  final double gap;
  final VoidCallback? onTap;

  const TextKeyValIcon({
    Key? key,
    required this.val,
    this.kkey = 'By',
    this.color = AppColors.secondary_20,
    this.colorIcon = AppColors.secondary_20,
    this.colorBg = AppColors.secondary_95,
    this.icon = MdiIcons.pencil,
    this.gap = 5,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextKeyVal(
          kkey,
          val,
          gap: gap,
        ),
        AppIconButton(
          icon: icon,
          iconSize: 15,
          color: colorIcon,
          colorBg: colorBg,
          pl: gap,
        )
      ],
    );
  }
}

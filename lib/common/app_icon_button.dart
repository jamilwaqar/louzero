import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final Color color;
  final Color colorBg;
  final double pl;
  final double pr;
  final double pt;
  final double pb;

  const AppIconButton(
      {Key? key,
      this.size = 24,
      this.icon = Icons.close,
      this.iconSize = 18,
      this.color = AppColors.secondary_60,
      this.colorBg = AppColors.secondary_95,
      this.pt = 0,
      this.pb = 0,
      this.pl = 0,
      this.pr = 0,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: pt, left: pl, right: pr, bottom: pb),
      child: Material(
        elevation: 0,
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: Center(
          child: GestureDetector(
            onTap: onTap ?? () {},
            child: Ink(
                width: size,
                height: size,
                decoration: ShapeDecoration(
                  color: colorBg,
                  shape: const CircleBorder(),
                ),
                child: Icon(icon, color: color, size: iconSize)),
          ),
        ),
      ),
    );
  }
}

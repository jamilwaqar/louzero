import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color color;
  final Color colorBg;
  final double pl;
  final double pr;
  final double pt;
  final double pb;

  const AppIconButton(
      {Key? key,
      this.size = 40,
      this.icon = Icons.close,
      this.color = AppColors.secondary_60,
      this.colorBg = AppColors.secondary_95,
      this.pt = 8,
      this.pb = 0,
      this.pl = 8,
      this.pr = 8,
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
          child: Ink(
            width: size,
            height: size,
            decoration: ShapeDecoration(
              color: colorBg,
              shape: const CircleBorder(),
            ),
            child: IconButton(
              splashColor: Colors.transparent,
              iconSize: size / 2,
              icon: Icon(icon),
              color: color,
              onPressed: onTap ?? () {},
            ),
          ),
        ),
      ),
    );
  }
}

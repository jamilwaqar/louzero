import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppNavButton extends StatelessWidget {
  AppNavButton({
    Key? key,
    required this.title,
    this.icon,
    this.count,
    this.onPressed,
    this.selected = false,
    this.color = AppColors.darkest,
    this.colorIco = AppColors.dark_1,
    this.colorBg = AppColors.light_2,
    this.mt = 0,
    this.mb = 0,
    this.ml = 0,
    this.mr = 0,
  }) : super(key: key);

  final Color color;
  final Color colorBg;
  final Color colorIco;
  final String title;
  final IconData? icon;
  final int? count;
  final VoidCallback? onPressed;
  final bool selected;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        // height: 48,
        margin: EdgeInsets.only(right: mr, left: ml, top: mt, bottom: mb),
        decoration: BoxDecoration(
            color: selected ? colorBg : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(999))),
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                icon,
                color: colorIco,
                size: 22,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

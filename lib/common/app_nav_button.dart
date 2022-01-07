import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppNavButton extends StatelessWidget {
  const AppNavButton({
    Key? key,
    required this.title,
    this.icon,
    this.count,
    this.onPressed,
    this.selected = false,
    this.color = AppColors.secondary_20,
    this.colorIco = AppColors.primary_60,
    this.colorBg,
    this.mt = 0,
    this.mb = 0,
    this.ml = 0,
    this.mr = 0,
  }) : super(key: key);

  final Color color;
  final Color? colorBg;
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
            color: selected
                ? colorBg ?? AppColors.secondary_60.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(999))),
        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: Icon(
                icon,
                color: selected ? colorIco : AppColors.secondary_60,
                size: 24,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: AppStyles.labelBold.copyWith(color: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}

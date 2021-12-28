import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    Key? key,
    this.mt = 0,
    this.mb = 24,
    this.ml = 0,
    this.mr = 0,
    this.color = AppColors.light_3,
    this.size = 1,
  }) : super(key: key);

  final double mt;
  final double mb;
  final double ml;
  final double mr;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: mt,
        bottom: mb,
        left: ml,
        right: mr,
      ),
      child: Divider(
        color: color,
        thickness: size,
        height: size,
      ),
    );
  }
}

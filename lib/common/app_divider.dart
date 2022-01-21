import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    Key? key,
    this.mt = 16,
    this.mb = 16,
    this.ml = 0,
    this.mr = 0,
    this.color = AppColors.secondary_90,
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
    return Stack(
      children: [
        Container(
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
        ),
      ],
    );
  }
}

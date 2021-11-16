import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextHeader extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final double mt; // margin top (defalt:0)
  final double mb; // margin bottom (default:20)

  const AppTextHeader(this.text,
      {Key? key,
      this.size = 33.0,
      this.color = AppColors.dark_2,
      this.mt = 0.0,
      this.mb = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt, bottom: mb),
      child: Text(text,
          style: TextStyle(
            fontSize: size,
            color: color,
            fontFamily: 'Roboto',
            letterSpacing: -0.75,
          )),
    );
  }
}

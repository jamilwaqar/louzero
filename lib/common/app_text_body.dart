import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextBody extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final double mt; // margin top (defalt:0)
  final double mb; // margin bottom (default:20)
  final double pl; // padding Left (default:0)
  final double pr; // padding Left (default:0)
  final double? px; // padding Left/Right convenience prop

  const AppTextBody(this.text,
      {Key? key,
      this.size = 16.0,
      this.color = AppColors.dark_1,
      this.mt = 0.0,
      this.mb = 0.0,
      this.pl = 0.0,
      this.pr = 0.0,
      this.px})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt, bottom: mb),
      padding: EdgeInsets.only(left: px ?? pl, right: px ?? pr),
      child: Text(text,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.normal,
            color: color,
            fontFamily: 'Roboto',
          )),
    );
  }
}

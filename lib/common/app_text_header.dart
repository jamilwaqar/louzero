import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextHeader extends StatelessWidget {
  const AppTextHeader(
    this.text, {
    Key? key,
    this.size = 33.0,
    this.color = AppColors.dark_2,
    this.mt = 0.0,
    this.mb = 16,
    this.alignLeft = false,
    this.icon,
  }) : super(key: key);

  final IconData? icon;
  final String text;
  final double size;
  final Color color;
  final double mt; // margin top (defalt:0)
  final double mb; // margin bottom (default:20)
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt, bottom: mb),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            alignLeft ? MainAxisAlignment.start : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: icon != null ? true : false,
            child: SizedBox(
              height: size,
              child: Icon(
                icon,
                size: size,
              ),
            ),
          ),
          SizedBox(width: size * 0.35),
          Text(text,
              style: TextStyle(
                fontSize: size,
                color: color,
                fontFamily: 'Roboto',
                letterSpacing: -0.75,
              )),
        ],
      ),
    );
  }
}

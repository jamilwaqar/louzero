import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextBody extends StatelessWidget {
  const AppTextBody(this.text,
      {Key? key,
      this.size = 16.0,
      this.color = AppColors.dark_1,
      this.mt = 0.0,
      this.mb = 0.0,
      this.pl = 0.0,
      this.pr = 0.0,
      this.bold = false,
      this.center = false,
      this.px})
      : super(key: key);

  final String text;
  final double size;
  final Color color;
  final bool center;
  final bool bold;
  final double mt; // margin top (defalt:0)
  final double mb; // margin bottom (default:20)
  final double pl; // padding Left (default:0)
  final double pr; // padding Left (default:0)
  final double? px; // padding Left/Right convenience prop

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt, bottom: mb),
      padding: EdgeInsets.only(left: px ?? pl, right: px ?? pr),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: center
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.stretch,
              children: [
                Text(
                  text,
                  textAlign: center ? TextAlign.center : TextAlign.left,
                  style: appTextBodyStyle(size: size, bold: bold, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle appTextBodyStyle({
  size = 16.0,
  bold = false,
  color = AppColors.darkest,
}) {
  return TextStyle(
    fontSize: size,
    fontWeight: bold ? FontWeight.bold : FontWeight.w400,
    color: color,
    fontFamily: 'Roboto',
  );
}

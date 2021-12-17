import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({
    Key? key,
    this.width = 8,
    this.size = 100,
    this.pad = 0,
    this.foreground = AppColors.orange,
    this.background = AppColors.secondary_90,
  }) : super(key: key);
  final double pad;
  final double size;
  final double width;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: Container(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            backgroundColor: background,
            color: foreground,
            strokeWidth: width,
          ),
        ),
      ),
    );
  }
}

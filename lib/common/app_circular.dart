import 'package:flutter/material.dart';

class AppCircular extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color valueColor;

  const AppCircular(
      {Key? key,
      this.size = 25,
      this.strokeWidth = 3,
      this.valueColor = const Color(0xFF4B3EDC)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor)),
    );
  }
}
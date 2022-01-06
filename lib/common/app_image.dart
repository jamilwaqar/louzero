import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppImage extends StatelessWidget {
  final String asset;
  final double width;
  final double height;
  final Color color;
  final BoxFit? fit;
  final bool isSvg;

  const AppImage(this.asset,
      {required this.width,
      required this.height,
      this.fit,
      this.isSvg = false,
      this.color = AppColors.icon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        'assets/icons/$asset.svg',
        width: width,
        height: height,
        color: color,
      );
    } else {
      return Image.asset('assets/icons/$asset.png',
          width: width, height: height, fit: fit);
    }
  }
}

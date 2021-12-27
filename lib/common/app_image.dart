import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String asset;
  final double width;
  final double height;
  final BoxFit? fit;
  const AppImage(this.asset,
      {required this.width, required this.height, this.fit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/icons/$asset.png',
        width: width, height: height, fit: fit);
  }
}

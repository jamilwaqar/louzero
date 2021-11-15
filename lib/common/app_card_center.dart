import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/decoration.dart';

class AppCardCenter extends StatelessWidget {
  const AppCardCenter({
    Key? key,
    required this.child,
    this.width = 0,
  }) : super(key: key);
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    var _swidth = MediaQuery.of(context).size.width;
    var _default = _swidth * 0.18;
    var _width =
        width > 0 && width < _swidth ? (_swidth - width) / 2 : _default;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: _width,
          ),
          padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
          decoration: BoxDecorationEx.shadowEffect(
              borderRadius: BorderRadius.circular(16),
              blurRadius: 3,
              shadowOffset: const Offset(0, 1),
              shadowRadius: 2,
              backgroundColor: AppColors.lightest),
          child: child,
        )
      ],
    );
  }
}

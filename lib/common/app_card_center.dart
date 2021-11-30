import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';


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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppCard(
            child: child,
            ml: _width,
            mr: _width,
            px: 24,
            py: 32,
          )
        ],
      ),
    );
  }
}

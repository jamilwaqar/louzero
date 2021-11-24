import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppFlexColumn extends StatelessWidget {
  const AppFlexColumn({
    Key? key,
    required this.children,
    this.ml = 0,
    this.mr = 0,
    this.flex = 1,
  }) : super(key: key);

  final List<Widget> children;
  final double ml;
  final double mr;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(left: ml, right: mr),
        child: Column(
          children: [
            ...children,
          ],
        ),
      ),
    );
  }
}

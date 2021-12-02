import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.children,
    this.pt = 24,
    this.pb = 24,
    this.pl = 24,
    this.pr = 24,
    this.mt = 0,
    this.mb = 16,
    this.ml = 24,
    this.mr = 24,
  }) : super(key: key);
  final List<Widget> children;
  final double pt;
  final double pb;
  final double pl;
  final double pr;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    var margin = EdgeInsets.only(
      top: mt,
      left: ml,
      right: mr,
      bottom: mb,
    );
    var padding = EdgeInsets.only(
      top: pt,
      left: pl,
      right: pr,
      bottom: pb,
    );

    return _elevatedContainer(
        elevation: 2,
        margin: margin,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ));
  }

  Widget _elevatedContainer(
      {required Widget child,
      EdgeInsets? margin,
      EdgeInsets? padding,
      double elevation = 0}) {
    return Container(
      margin: margin,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        elevation: elevation,
        shadowColor: AppColors.darkest.withOpacity(0.5),
        child: Container(
            padding: padding,
            decoration: BoxDecoration(
                color: AppColors.lightest,
                border: Border.all(
                    color: AppColors.medium_1.withOpacity(.5), width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: child),
      ),
    );
  }
}

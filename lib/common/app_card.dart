import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.children,
    this.radius = 8,
    this.pt = 24,
    this.pb = 24,
    this.pl = 24,
    this.pr = 24,
    this.mt = 0,
    this.mb = 16,
    this.ml = 24,
    this.mr = 24,
    this.mx,
    this.my,
    this.px,
    this.py,
    this.color = Colors.white,
  }) : super(key: key);
  final List<Widget> children;
  final double radius;
  final double pt;
  final double pb;
  final double pl;
  final double pr;
  final double? px;
  final double? py;
  final double mt;
  final double mb;
  final double ml;
  final double mr;
  final double? mx;
  final double? my;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var margin = EdgeInsets.only(
      top: my ?? mt,
      bottom: my ?? mb,
      left: mx ?? ml,
      right: mx ?? mr,
    );
    var padding = EdgeInsets.only(
      top: py ?? pt,
      bottom: py ?? pb,
      left: px ?? pl,
      right: px ?? pr,
    );

    return _appCard(
        elevation: 2,
        margin: margin,
        color: color,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ));
  }

  Widget _appCard(
      {required Widget child,
      EdgeInsets? margin,
      EdgeInsets? padding,
      double elevation = 0,
      Color color = Colors.white}) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: Card(
          color: color,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.light_2),
            borderRadius: BorderRadius.circular(radius),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: elevation,
          shadowColor: AppColors.darkest.withOpacity(0.5),
          child: Container(
            padding: padding,
            child: child,
          )),
    );
  }
}

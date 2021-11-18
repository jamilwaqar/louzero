import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/decoration.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.children,
    this.width = 0,
    this.pt = 32,
    this.pb = 0,
    this.pl = 0,
    this.pr = 0,
    this.px = 24,
    this.py = 0,
    this.p = 0,
    this.mt = 0,
    this.mb = 16,
    this.ml = 0,
    this.mr = 0,
    this.mx = 24,
    this.my = 0,
    this.m = 0,
  }) : super(key: key);
  final List<Widget> children;
  final double width;
  // spacing props (margin / padding)
  final double pt;
  final double pb;
  final double pl;
  final double pr;
  final double px;
  final double py;
  final double p;
  final double mt;
  final double mb;
  final double ml;
  final double mr;
  final double mx;
  final double my;
  final double m;

  @override
  Widget build(BuildContext context) {
    var margin = EdgeInsets.only(
      top: m > 0
          ? m
          : my > 0
              ? my
              : mt,
      left: m > 0
          ? m
          : mx > 0
              ? mx
              : ml,
      right: m > 0
          ? m
          : mx > 0
              ? mx
              : ml,
      bottom: m > 0
          ? m
          : my > 0
              ? my
              : mt,
    );
    var padding = EdgeInsets.only(
      top: p > 0
          ? p
          : py > 0
              ? py
              : pt,
      left: p > 0
          ? p
          : px > 0
              ? px
              : pl,
      right: p > 0
          ? p
          : px > 0
              ? px
              : pr,
      bottom: p > 0
          ? p
          : py > 0
              ? py
              : pb,
    );

    return Column(
      children: [
        Container(
          margin: margin,
          padding: padding,
          decoration: BoxDecorationEx.shadowEffect(
              borderRadius: BorderRadius.circular(8),
              blurRadius: 3,
              shadowOffset: const Offset(0, 1),
              shadowRadius: 2,
              backgroundColor: AppColors.lightest),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

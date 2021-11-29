import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/extensions.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.child,
    this.width = 0,
    this.px = 0,
    this.py = 0,
    this.mx = 0,
    this.my = 0,
    this.mt = 0,
    this.mb = 0,
    this.ml = 0,
    this.mr = 0,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double mt;
  final double mb;
  final double ml;
  final double mr;
  final double px;
  final double py;
  final double mx;
  final double my;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt, left: ml, right: mr, bottom: mb),
      padding: EdgeInsets.only(top: py, left: px, right: px, bottom: py),
      decoration: BoxDecorationEx.shadowEffect(
          borderRadius: BorderRadius.circular(8),
          blurRadius: 3,
          shadowOffset: const Offset(0, 1),
          shadowRadius: 2,
          backgroundColor: AppColors.lightest),
      child: child,
    );
  }
}

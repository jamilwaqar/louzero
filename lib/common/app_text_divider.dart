import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextDivider extends StatelessWidget {
  const AppTextDivider({
    Key? key,
    this.label = 'or',
    this.mt = 24,
    this.mb = 24,
    this.ml = 0,
    this.mr = 0,
  }) : super(key: key);

  final String label;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt, bottom: mt, left: ml, right: mr),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.light_3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(label,
                style: const TextStyle(
                  color: AppColors.dark_1,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                )),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.light_3,
            ),
          ),
        ],
      ),
    );
  }
}

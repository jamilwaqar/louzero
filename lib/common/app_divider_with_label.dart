import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'common.dart';

class AppDividerWithLabel extends StatelessWidget {
  final String label;
  final double mt;
  final double mb;
  final double ml;
  final double mr;
  final double size;
  final Color colorBd;
  final Color colorText;
  final Color colorBg;

  const AppDividerWithLabel({
    required this.label,
    this.size = 1,
    this.mt = 0,
    this.mb = 0,
    this.ml = 0,
    this.mr = 0,
    this.colorBd = AppColors.secondary_90,
    this.colorBg = AppColors.secondary_99,
    this.colorText = AppColors.secondary_50,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ml, right: mr),
      child: Column(
        children: [
          AppDivider(
            mt: mt,
            mb: 0,
          ),
          RowSplit(
            right: Container(
              width: 100,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: colorBg,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )),
              child: Text(label,
                  style: AppStyles.labelBold
                      .copyWith(fontSize: 14, color: colorText)),
            ),
          ),
          SizedBox(
            height: mb,
          )
        ],
      ),
    );
  }
}

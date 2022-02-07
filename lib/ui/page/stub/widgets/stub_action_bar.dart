import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';

class StubActionBar extends StatelessWidget {
  final String label;
  final Color colorTxt;
  final Color colorBtn;
  final Color colorBg;
  final bool showBtn;
  final String textBtn;
  final double height;
  final Function()? onPressed;
  const StubActionBar(
      {required this.label,
      this.colorTxt = AppColors.white,
      this.colorBtn = AppColors.secondary_50,
      this.colorBg = AppColors.secondary_70,
      this.showBtn = false,
      this.textBtn = 'Reset',
      this.height = 80,
      this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      alignment: const Alignment(0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      color: colorBg,
      child: RowSplit(
        left: Text(
          label,
          style: AppStyles.headerLarge.copyWith(color: colorTxt),
        ),
        right: showBtn
            ? Buttons.submit(textBtn, colorBg: colorBtn, onPressed: onPressed)
            : const SizedBox.shrink(),
      ),
    );
  }
}

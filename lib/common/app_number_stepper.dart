import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/common.dart';

class AppNumberStepper extends StatefulWidget {
  final int max;
  final int min;
  final int incrementSize;

  const AppNumberStepper(
      {Key? key, this.max = 99, this.min = 0, this.incrementSize = 1})
      : super(key: key);

  @override
  State<AppNumberStepper> createState() => _AppNumberStepperState();
}

class _AppNumberStepperState extends State<AppNumberStepper> {
  int count = 0;

  void _increment() {
    if (count < widget.max) {
      setState(() {
        count = count + widget.incrementSize;
      });
    }
  }

  void _decrement() {
    if (count > widget.min) {
      setState(() {
        count = count - widget.incrementSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 124,
      decoration: const BoxDecoration(
        color: AppColors.secondary_95,
        borderRadius: Common.border_99,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIconButton(
            icon: Icons.remove,
            size: 32,
            iconSize: 28,
            pl: 8,
            colorBg: AppColors.secondary_90,
            onTap: _decrement,
          ),
          Text('$count',
              style: AppStyles.labelBold
                  .copyWith(fontSize: 20, color: AppColors.secondary_40)),
          AppIconButton(
            icon: Icons.add,
            iconSize: 28,
            size: 32,
            pr: 8,
            colorBg: AppColors.secondary_90,
            onTap: _increment,
          )
        ],
      ),
    );
  }
}

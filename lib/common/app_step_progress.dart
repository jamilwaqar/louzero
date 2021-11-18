import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppStepProgress extends StatelessWidget {
  AppStepProgress({Key? key}) : super(key: key);
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _key,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _StepNumberDash(stepNumber: 1, startSize: 0, complete: true),
            _StepNumberDash(stepNumber: 2),
            _StepNumberDash(stepNumber: 3),
            _StepNumberDash(stepNumber: 4, endSize: 0),
          ],
        ),
      ],
    );
  }
}

class _StepNumberDash extends StatelessWidget {
  const _StepNumberDash(
      {Key? key,
      this.stepNumber = 0,
      this.stepSize = 40,
      this.dashSize = 40,
      this.endSize = 20,
      this.startSize = 20,
      this.selected = false,
      this.complete = false})
      : super(key: key);

  final int stepNumber;
  final double dashSize;
  final double stepSize;
  final double startSize;
  final double endSize;
  final bool selected;
  final bool complete;
  final IconData icon = Icons.check;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StepDash(
              size: startSize != 20 ? startSize : dashSize,
            ),
            _StepNumber(
              stepNumber,
              size: stepSize,
              icon: complete ? icon : null,
            ),
            _StepDash(
              size: endSize != 20 ? endSize : dashSize,
            ),
          ],
        ),
      ],
    );
  }
}

class _StepNumber extends StatelessWidget {
  const _StepNumber(this.step,
      {Key? key,
      this.size = 50,
      this.color = AppColors.lightest,
      this.colorBorder = AppColors.medium_1,
      this.colorText = AppColors.black,
      this.icon})
      : super(key: key);
  final int step;
  final double size;
  final Color color;
  final Color colorBorder;
  final Color colorText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: colorBorder, width: 2)),
          child: Center(
            child: icon != null
                ? Icon(icon)
                : Text(
                    step.toString(),
                    style: TextStyle(fontSize: size * 0.45, color: colorText),
                  ),
          ),
        ),
      ],
    );
  }
}

class _StepDash extends StatelessWidget {
  const _StepDash({Key? key, this.size = 50, this.color = AppColors.medium_1})
      : super(key: key);
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: size,
      color: color,
    );
  }
}

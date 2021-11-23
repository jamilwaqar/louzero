import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

const Color black = AppColors.dark_2;
const Color blackText = AppColors.black;
const Color grey = AppColors.medium_1;
const Color white = AppColors.lightest;

class AppStepProgress extends StatelessWidget {
  AppStepProgress(
      {Key? key,
      this.selected = 0,
      this.steps = const ['Step One', 'Step Two', 'Step Three']})
      : super(key: key);

  final _key = GlobalKey();
  final List<String> steps;
  final int selected;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < steps.length; i++) {
      children.add(_StepNumberDash(
        stepNumber: i + 1,
        complete: i < selected,
        selected: i == selected,
        firstStep: i == 0,
        lastStep: i == steps.length - 1,
        label: steps[i],
      ));
    }

    return Column(
      key: _key,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ],
    );
  }
}

class _StepNumberDash extends StatelessWidget {
  const _StepNumberDash({
    Key? key,
    this.stepNumber = 0,
    this.stepSize = 40,
    this.dashSize = 50,
    this.endSize = 20,
    this.startSize = 20,
    this.selected = false,
    this.complete = false,
    this.firstStep = false,
    this.lastStep = false,
    this.label = "",
  }) : super(key: key);

  final String label;
  final int stepNumber;
  final double dashSize;
  final double stepSize;
  final double startSize;
  final double endSize;
  final bool selected;
  final bool complete;
  final bool firstStep;
  final bool lastStep;
  final IconData icon = Icons.check;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StepDash(
                  size: dashSize,
                  selected: selected || complete,
                  color: firstStep ? Colors.black.withOpacity(0) : grey,
                  colorSelected:
                      firstStep ? Colors.black.withOpacity(0) : black,
                ),
                _StepNumber(
                  stepNumber,
                  selected: selected || complete,
                  size: stepSize,
                  icon: complete ? icon : null,
                ),
                _StepDash(
                  size: dashSize,
                  selected: selected || complete,
                  color: lastStep ? Colors.black.withOpacity(0) : grey,
                  colorSelected: lastStep ? Colors.black.withOpacity(0) : black,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(label,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: selected || complete ? blackText : grey))
          ],
        ),
      ],
    );
  }
}

class _StepNumber extends StatelessWidget {
  const _StepNumber(
    this.step, {
    Key? key,
    this.size = 50,
    this.selected = false,
    this.color = white,
    this.colorBorder = grey,
    this.colorText = black,
    this.colorSelected = white,
    this.colorBorderSelected = black,
    this.colorTextSelected = blackText,
    this.icon,
  }) : super(key: key);
  final bool selected;
  final int step;
  final double size;
  final Color color;
  final Color colorBorder;
  final Color colorText;
  final Color colorSelected;
  final Color colorBorderSelected;
  final Color colorTextSelected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    var tx = icon != null
        ? color
        : selected
            ? colorTextSelected
            : colorText;
    var bg = icon != null ? colorBorderSelected : color;
    var bd = selected || icon != null ? colorBorderSelected : colorBorder;
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
              border: Border.all(color: bd, width: 2)),
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    color: tx,
                  )
                : Text(
                    step.toString(),
                    style: TextStyle(fontSize: size * 0.45, color: tx),
                  ),
          ),
        ),
      ],
    );
  }
}

class _StepDash extends StatelessWidget {
  const _StepDash({
    Key? key,
    this.size = 50,
    this.color = grey,
    this.colorSelected = black,
    this.selected = false,
  }) : super(key: key);
  final double size;
  final Color color;
  final Color colorSelected;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: size,
      color: selected ? colorSelected : color,
    );
  }
}

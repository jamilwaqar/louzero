import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'app_text_body.dart';
import 'app_text_header.dart';

class StepProgressItem {
  final String title;
  final String subtitle;
  final String label;
  StepProgressItem({
    required this.title,
    required this.subtitle,
    required this.label,
  });
}

class AppStepProgress extends StatelessWidget {
  AppStepProgress({
    Key? key,
    this.selected = 0,
    this.stepItems = const [],
  }) : super(key: key);

  final _key = GlobalKey();
  final List<StepProgressItem> stepItems;
  final int selected;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < stepItems.length; i++) {
      children.add(_StepNumberDash(
        stepNumber: i + 1,
        complete: i < selected,
        selected: i == selected,
        firstStep: i == 0,
        lastStep: i == stepItems.length - 1,
        label: stepItems[i].label,
      ));
    }

    var title = selected >= 0 && selected < stepItems.length
        ? stepItems[selected].title
        : '';
    var subtitle = selected >= 0 && selected < stepItems.length
        ? stepItems[selected].subtitle
        : '';

    return Column(
      key: _key,
      children: [
        Column(
          children: [
            AppTextHeader(
              title,
              mt: 32,
              mb: 8,
            ),
            AppTextBody(
              subtitle,
              mb: 32,
              bold: true,
              center: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ],
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
                  color: firstStep
                      ? Colors.black.withOpacity(0)
                      : AppColors.medium_1,
                  colorSelected: firstStep
                      ? Colors.black.withOpacity(0)
                      : AppColors.dark_2,
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
                  color: lastStep
                      ? Colors.black.withOpacity(0)
                      : AppColors.medium_1,
                  colorSelected:
                      lastStep ? Colors.black.withOpacity(0) : AppColors.dark_2,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(label,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: selected || complete
                        ? AppColors.black
                        : AppColors.medium_1))
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
    this.color = AppColors.lightest,
    this.colorBorder = AppColors.medium_1,
    this.colorText = AppColors.dark_2,
    this.colorSelected = AppColors.lightest,
    this.colorBorderSelected = AppColors.dark_2,
    this.colorTextSelected = AppColors.black,
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
    this.color = AppColors.medium_1,
    this.colorSelected = AppColors.dark_2,
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

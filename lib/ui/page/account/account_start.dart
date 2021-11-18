import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/base_scaffold.dart';

class AccountStart extends StatefulWidget {
  const AccountStart({Key? key}) : super(key: key);

  @override
  _AccountStartState createState() => _AccountStartState();
}

class _AccountStartState extends State<AccountStart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  const AppTextHeader(
                    "To start, let’s get some basic info.",
                    mt: 32,
                    mb: 8,
                  ),
                  const AppTextBody(
                    'You can always make changes later in Settings',
                    mb: 32,
                  ),
                  StepProgress()
                ],
              )),
          Expanded(
            flex: 3,
            child: PageView(children: const [
              BasePage(label: 'Company Details', icon: Icons.location_city),
              BasePage(label: 'Customer Types', icon: Icons.person),
              BasePage(label: 'Job Types', icon: Icons.business_center),
              BasePage(label: 'Customers', icon: Icons.person, heading: false),
            ]),
          )
        ],
      ),
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage(
      {Key? key, required this.label, this.icon, this.heading = true})
      : super(key: key);
  final String label;
  final IconData? icon;
  final bool heading;
  @override
  Widget build(BuildContext context) {
    var _icon = icon ?? null;
    return AppCard(
        m: 24,
        p: 24,
        child: Column(
          children: [
            Visibility(
                visible: heading,
                child: AppTextHeader(
                  label,
                  alignLeft: true,
                  icon: _icon,
                  size: 24,
                )),
          ],
        ));
  }
}

class StepProgress extends StatelessWidget {
  StepProgress({Key? key}) : super(key: key);
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _key,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            StepNumberDash(stepNumber: 1, startSize: 0, complete: true),
            StepNumberDash(stepNumber: 2),
            StepNumberDash(stepNumber: 3),
            StepNumberDash(stepNumber: 4, endSize: 0),
          ],
        ),
      ],
    );
  }
}

class StepNumberDash extends StatelessWidget {
  const StepNumberDash(
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
            StepDash(
              size: startSize != 20 ? startSize : dashSize,
            ),
            StepNumber(
              stepNumber,
              size: stepSize,
              icon: complete ? icon : null,
            ),
            StepDash(
              size: endSize != 20 ? endSize : dashSize,
            ),
          ],
        ),
      ],
    );
  }
}

class StepNumber extends StatelessWidget {
  const StepNumber(this.step,
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

class StepDash extends StatelessWidget {
  const StepDash({Key? key, this.size = 50, this.color = AppColors.medium_1})
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

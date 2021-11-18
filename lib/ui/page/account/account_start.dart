import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_step_progress.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
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
                  AppStepProgress()
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

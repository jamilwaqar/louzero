import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_tabs.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum SelectCustomerType { none, search, select }

class JobsHome extends StatelessWidget {
  const JobsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: _body(),
      subheader: 'Repair',
      footerEnd: const [
        AppButton(
          fontSize: 16,
          label: 'Job Status',
          icon: MdiIcons.calculator,
          colorBg: AppColors.secondary_20,
          colorIcon: AppColors.accent_1,
        )
      ],
    );
  }

  Widget _body() {
    List<Widget> list = [
      const AppCardTabs(
          radius: 24,
          children: [
            Icon(MdiIcons.cardAccountDetails,
                size: 190, color: AppColors.orange),
            Icon(MdiIcons.calendar, size: 190, color: AppColors.orange),
            Icon(MdiIcons.creditCard, size: 190, color: AppColors.orange),
          ],
          length: 3,
          tabNames: ['Job Details', 'Schedule', 'Billing'])
    ];
    return ListView(
      children: list,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_tabs.dart';
import 'package:louzero/common/app_pop_menu.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/widget/appbar/app_bar_page_header.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum SelectCustomerType { none, search, select }

class JobsHome extends StatelessWidget {
  JobsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageHeader(
        title: SizedBox(
          height: 64,
          child: Image.asset("assets/icons/general/logo_icon.png"),
        ),
        context: context,
        leadingTxt: "Jobs",
        actions: [_userMenu()],
        footerStart: [
          Text('Repair',
              style: GoogleFonts.barlowCondensed(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ))
        ],
        footerEnd: const [
          AppButton(
            fontSize: 16,
            label: 'Job Status',
            icon: MdiIcons.calculator,
            color: AppColors.secondary_20,
            colorIcon: AppColors.accent_1,
          )
        ],
      ),
      backgroundColor: AppColors.secondary_99,
      body: _body(),
    );
  }

  Widget _body() {
    List<Widget> list = [
      AppCardTabs(
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

  Widget _userMenu() {
    return AppPopMenu(
      items: [
        PopMenuItem(
          label: 'My Account',
          icon: Icons.person_rounded,
          onTap: () {},
        ),
        PopMenuItem(
          label: 'Settings',
          icon: Icons.settings,
          onTap: () {},
        ),
        PopMenuItem(
          label: 'Account Setup',
          icon: MdiIcons.briefcase,
          onTap: () {},
        ),
        PopMenuItem(
          label: 'Log Out',
          icon: Icons.exit_to_app,
          onTap: () {},
        )
      ],
      button: const [
        AppAvatar(
          path: 'assets/mocks/profile_corey_2.png',
          size: 40,
          borderColor: AppColors.lightest,
        ),
        Icon(Icons.arrow_drop_down, color: AppColors.lightest)
      ],
    );
  }
}

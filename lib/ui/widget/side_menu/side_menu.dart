import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_icon_button.dart';
import 'package:louzero/common/app_nav_button.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/account/account_setup.dart';
import 'package:louzero/ui/page/company/companies.dart';
import 'package:louzero/ui/page/customer/customers.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';
import 'package:louzero/ui/page/demo/demo.dart';
import 'package:louzero/ui/page/settings/settings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SideMenuView extends StatefulWidget {
  const SideMenuView({Key? key, this.sideMenuKey}) : super(key: key);
  final GlobalKey<DrawerControllerState>? sideMenuKey;

  @override
  _SideMenuViewState createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> {
  final String? _profileImagePath = 'assets/mocks/profile_corey_2.png';

  @override
  Widget build(BuildContext context) {
    // _sideMenuKey.currentState?.open();
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: 360,
        child: Drawer(
          elevation: 0,
          key: widget.sideMenuKey,
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(16),
            // padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecorationEx.shadowEffect(
              shadowOffset: const Offset(0, 6),
              shadowRadius: 3,
              shadowColor: Colors.black.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              backgroundColor: AppColors.secondary_99,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppIconButton(
                      onTap: () {
                        _pop();
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 8),
                  child: _profile(),
                ),
                _primaryNav(),
                _secondaryNav()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _primaryNav() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppNavButton(
                title: "Dashboard",
                selected: true,
                icon: Icons.dashboard,
                onPressed: () {
                  _pop();
                  Get.to(()=> DashboardPage());
                },
              ),
              AppNavButton(
                title: "Companies",
                icon: Icons.home_work,
                onPressed: () {
                  _pop();
                  Get.to(()=> CompanyListPage());
                },
              ),
              AppNavButton(
                title: "Customers",
                icon: Icons.person,
                onPressed: () {
                  _pop();
                  Get.to(()=> CustomerListPage());
                },
              ),
              AppNavButton(
                title: "Jobs",
                icon: MdiIcons.briefcase,
                onPressed: () {
                  _pop();
                },
              ),
              AppNavButton(
                title: "Schedule",
                icon: MdiIcons.calendar,
                onPressed: () {
                  _pop();
                },
              ),
              AppNavButton(
                title: "Inventory",
                icon: MdiIcons.clipboardText,
                onPressed: () {
                  _pop();
                },
              ),
              AppNavButton(
                title: "Reports",
                icon: Icons.bar_chart,
                onPressed: () {
                  _pop();
                },
              ),
              AppNavButton(
                title: "Settings",
                icon: Icons.settings,
                onPressed: () {
                  _pop();
                  NavigationController()
                      .pushTo(context, child: const SettingsPage());
                },
              ),
              AppNavButton(
                title: "Demo",
                icon: Icons.star_border_outlined,
                onPressed: () {
                  _pop();
                  NavigationController().pushTo(context, child: demo());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _secondaryNav() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          AppNavButton(
            title: "Sign Out",
            icon: MdiIcons.logout,
            colorIco: AppColors.primary_1,
            onPressed: () {
              _pop();
              NavigationController()
                  .pushTo(context, child: const AccountSetup());
            },
          ),
        ],
      ),
    );
  }

  Widget _profile() {
    return Column(
      children: [
        AppAvatar(path: _profileImagePath, size: 96),
        const SizedBox(height: 8),
        const Text('Corey Holton', style: appStyles.header_default),
        const SizedBox(height: 8),
        const Text(
          'Patio Pools and Spas',
          style: appStyles.label_default,
        ),
        const AppDivider(
          mt: 32,
          ml: 90,
          mr: 90,
          size: 2,
          color: AppColors.primary_50,
        )
      ],
    );
  }

  void _pop() => NavigationController().pop(context);
}

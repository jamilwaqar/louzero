import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_list_tile.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/ui/page/account/account_setup.dart';
import 'package:louzero/ui/page/customer/customers.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';
import 'package:louzero/ui/page/settings/settings.dart';
import 'package:louzero/ui/widget/cell/list/side_menu.dart';
import 'package:louzero/ui/widget/dialolg/popup/camera_option.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SideMenuView extends StatefulWidget {
  const SideMenuView({Key? key, this.sideMenuKey}) : super(key: key);
  final GlobalKey<DrawerControllerState>? sideMenuKey;

  @override
  _SideMenuViewState createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> {
  String? _profileImagePath;

  @override
  Widget build(BuildContext context) {
    // _sideMenuKey.currentState?.open();
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
        key: widget.sideMenuKey,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecorationEx.shadowEffect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            backgroundColor: AppColors.light_1,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48, bottom: 8),
                child: _profile(),
              ),
              Expanded(
                child: _primaryNav(),
              ),
              _secondaryNav()
            ],
          ),
        ),
      ),
    );
  }

  Widget _closeButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: AppColors.medium_3,
            ),
          )
        ],
      ),
    );
  }

  Widget _primaryNav() {
    return Padding(
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
                NavigationController().pushTo(context, child: DashboardPage());
              },
            ),
            AppNavButton(
              title: "Customers",
              icon: Icons.person,
              onPressed: () {
                _pop();
                NavigationController()
                    .pushTo(context, child: const CustomerListPage());
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
          ],
        ),
      ),
    );
  }

  Widget _secondaryNav() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppListTile(
          ml: 10,
          mb: 24,
          iconStart: Icons.content_paste_rounded,
          title: 'Account Setup',
          onTap: () {
            _pop();
            NavigationController().pushTo(context, child: const AccountSetup());
          },
        ),
      ],
    );
  }

  Widget _profile() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 96,
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  color: AppColors.medium_2,
                  image: _profileImagePath == null
                      ? null
                      : DecorationImage(
                          image: FileImage(File(_profileImagePath!)),
                          fit: BoxFit.cover)),
              child: _profileImagePath != null
                  ? null
                  : Text(
                      AuthManager.userModel!.initials,
                      style: const TextStyle(
                        color: AppColors.lightest,
                        fontWeight: FontWeight.w500,
                        fontSize: 40,
                      ),
                    ),
            ),
          ],
        ),
        AppTextBody(
          AuthManager.userModel!.fullName,
          size: 24,
          mt: 8,
          mb: 8,
          color: AppColors.darkest,
          center: true,
        ),
        const AppTextBody(
          'My Account',
          mb: 24,
          center: true,
        ),
        const AppDivider(
          ml: 90,
          mr: 90,
        )
      ],
    );
  }

  void _changeProfileImage() async {
    var option = await CameraOption.showCameraOptions(context);
    if (option is ImageSource) {
      var selectedImage = await ImagePicker().pickImage(source: option);
      setState(() {
        _profileImagePath = selectedImage?.path;
      });
      // selectedImage.
    }
  }

  void _pop() => NavigationController().pop(context);
}

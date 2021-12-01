import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:louzero/common/app_list_tile.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
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
          width: 288,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecorationEx.shadowEffect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              backgroundColor: AppColors.light_1),
          child: Column(
            children: [
              Padding(
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
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _changeProfileImage,
                child: Stack(
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
                          : const Text(
                              "MA",
                              style: TextStyle(
                                color: AppColors.lightest,
                                fontWeight: FontWeight.w500,
                                fontSize: 40,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 6,
                      child: Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: AppColors.light_1, width: 1),
                          color: AppColors.medium_3,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: AppColors.lightest,
                          size: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Mark Austen",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Text(
                  "My Account",
                  style: TextStyle(
                    color: AppColors.dark_1,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: AppColors.light_2,
                width: 176,
                height: 2,
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView(
                  children: [
                    SideMenuCell(
                      title: "Dashboard",
                      icon: const Icon(
                        Icons.dashboard,
                        color: AppColors.icon,
                      ),
                      onPressed: () {
                        _pop();
                        Get.to(()=> DashboardPage());
                      },
                    ),
                    SideMenuCell(
                      title: "Customers",
                      icon: const Icon(
                        Icons.person,
                        color: AppColors.icon,
                      ),
                      count: 0,
                      onPressed: () {
                        _pop();
                        Get.to(()=> const CustomerListPage());
                      },
                    ),
                    SideMenuCell(
                      title: "Jobs",
                      icon: const Icon(
                        MdiIcons.briefcase,
                        color: AppColors.dark_2,
                      ),
                      count: 0,
                      onPressed: () {
                        _pop();
                      },
                    ),
                    SideMenuCell(
                      title: "Schedule",
                      icon: const Icon(
                        MdiIcons.calendar,
                        color: AppColors.dark_2,
                      ),
                      onPressed: () {
                        _pop();
                      },
                    ),
                    SideMenuCell(
                      title: "Inventory",
                      icon: const Icon(
                        MdiIcons.clipboardText,
                        color: AppColors.dark_2,
                      ),
                      onPressed: () {
                        _pop();
                      },
                    ),
                    SideMenuCell(
                      title: "Reports",
                      icon: const Icon(
                        Icons.bar_chart,
                        color: AppColors.icon,
                      ),
                      onPressed: () {
                        _pop();
                      },
                    ),
                    SideMenuCell(
                      title: "Settings",
                      icon: const Icon(
                        Icons.settings,
                        color: AppColors.icon,
                      ),
                      onPressed: () {
                        _pop();
                        Get.to(()=> const SettingsPage());
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppListTile(
                      ml: 10,
                      mb: 24,
                      iconStart: Icons.content_paste_rounded,
                      title: 'Account Setup',
                      onTap: () {
                        _pop();
                        Get.to(()=> const AccountSetup());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

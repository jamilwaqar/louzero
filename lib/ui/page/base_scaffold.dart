import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/ui/widget/side_menu/side_menu.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({Key? key, this.child, this.hasKeyboard = false})
      : super(key: key);
  final Widget? child;
  final bool hasKeyboard;
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  List<PopMenuItem> items = [
    PopMenuItem(
        label: 'My Account',
        icon: Icons.person_rounded,
        onTap: () {
          print("account");
        }),
    PopMenuItem(
        label: 'Settings',
        icon: Icons.settings,
        onTap: () {
          print("settings");
        }),
    PopMenuItem(
        label: 'Account Setup',
        icon: MdiIcons.briefcase,
        onTap: () {
          print("settings");
        }),
    PopMenuItem(
        label: 'Log Out',
        icon: Icons.exit_to_app,
        onTap: () {
          print("exit");
        }),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: NavigationController().notifierInitLoading,
      builder: (ctx, isLoading, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: AuthStateManager().loggedIn,
          builder: (ctx, isLoggedIn, child) {
            return Scaffold(
              drawerScrimColor: Colors.black.withOpacity(0),
              key: _key,
              resizeToAvoidBottomInset: widget.hasKeyboard,
              backgroundColor: AppColors.dark_1,
              drawerEnableOpenDragGesture: false,
              appBar: AppBar(
                  backgroundColor: const Color(0xFF263842),
                  title: SizedBox(
                    height: 64,
                    child: Image.asset("assets/icons/general/logo_icon.png"),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      _key.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ), // Set menu icon at leading of AppBar
                  actions: [
                    AppPopMenu(
                      items: items,
                      button: const [
                        AppAvatar(
                          path: 'assets/mocks/profile_corey_2.png',
                          size: 40,
                          borderColor: AppColors.lightest,
                        ),
                        Icon(Icons.arrow_drop_down, color: AppColors.lightest)
                      ],
                    )
                  ]),
              drawer: const SideMenuView(),
              body: Container(
                color: const Color(0xFFF1F3F5),
                child: widget.child,
              ),
            );
          },
        );
      },
    );
  }
}

class PopMenuItem {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  const PopMenuItem({
    required this.label,
    this.icon,
    this.onTap,
  });
}

class AppPopMenu extends StatelessWidget {
  final List<PopMenuItem> items;
  final List<Widget> button;
  const AppPopMenu({Key? key, this.items = const [], this.button = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: Row(children: [
          if (button.isEmpty) const Icon(Icons.more_vert),
          if (button.isNotEmpty) ...button
        ]),
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.medium_2, width: 0)),
        itemBuilder: (BuildContext context) => items.map((item) {
              return popItem(item.label,
                  onTap: item.onTap, icon: item.icon ?? Icons.chevron_right);
            }).toList());
  }

  PopupMenuItem popItem(String label,
      {IconData icon = Icons.chevron_right, VoidCallback? onTap}) {
    return PopupMenuItem(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 8),
            Text(label)
          ],
        ));
  }
}

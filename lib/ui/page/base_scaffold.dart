import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_pop_menu.dart';
import 'package:louzero/common/app_spinner.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/ui/widget/side_menu/side_menu.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

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
  final navigatorKey = GlobalKey<NavigatorState>();

  void _logout() async {
    GetStorage().write(GSKey.isAuthUser, false);
    await AuthAPI(auth: Backendless.userService).logout();
    NavigationController().popToFirst(context);
    AuthManager().loggedIn.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: NavigationController().notifierInitLoading,
      builder: (ctx, isLoading, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: AuthManager().loggedIn,
          builder: (ctx, isLoggedIn, child) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Scaffold(
                    drawerScrimColor: Colors.black.withOpacity(0),
                    key: _key,
                    resizeToAvoidBottomInset: widget.hasKeyboard,
                    backgroundColor: AppColors.secondary_99,
                    drawerEnableOpenDragGesture: false,
                    appBar: AppBar(
                        elevation: 0,
                        backgroundColor: const Color(0xFF263842),
                        title: SizedBox(
                          height: 64,
                          child:
                              Image.asset("assets/icons/general/logo_icon.png"),
                        ),
                        leading: isLoggedIn
                            ? IconButton(
                                onPressed: () {
                                  _key.currentState?.openDrawer();
                                },
                                icon: const Icon(Icons.menu),
                              )
                            : null, // Set menu icon at leading of AppBar
                        actions: [
                          if (isLoggedIn)
                            AppPopMenu(
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
                                  onTap: _logout,
                                )
                              ],
                              button: const [
                                AppAvatar(
                                  path: 'assets/mocks/profile_corey_2.png',
                                  size: 40,
                                  borderColor: AppColors.lightest,
                                ),
                                Icon(Icons.arrow_drop_down,
                                    color: AppColors.lightest)
                              ],
                            )
                        ]),
                    drawer: isLoggedIn ? const SideMenuView() : null,
                    body: widget.child,
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      color: AppColors.secondary_95.withOpacity(0.6),
                      child: AppSpinner(
                        size: 160,
                        width: 8,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

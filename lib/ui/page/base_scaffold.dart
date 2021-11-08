import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/decoration.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/widget/dialolg/confirmation.dart';
import 'package:louzero/ui/widget/side_menu/side_menu.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: NavigationController().notifierInitLoading,
      builder: (ctx, isLoading, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: AuthStateManager().loggedIn,
                builder: (ctx, isLoggedIn, child) {
                  return Scaffold(
                    key: _key,
                    resizeToAvoidBottomInset: false,
                    backgroundColor: AppColors.dark_1,
                    drawerEnableOpenDragGesture: false,
                    drawer: const SideMenuView(),
                    body: SafeArea(
                      top: false,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                            child: Row(
                              mainAxisAlignment: isLoggedIn ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                              children: [
                                if (isLoggedIn)
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: _onMenu,
                                    child: const Icon(
                                      Icons.menu,
                                      color: AppColors.lightest,
                                    ),
                                  ),
                                SizedBox(
                                  height: 64,
                                  child: Image.asset("assets/icons/general/logo_icon.png"),
                                ),
                                if (isLoggedIn)
                                  PopupMenuButton(
                                      offset: const Offset(0, 40),
                                      onSelected: (value) {
                                        if (value == 3) {
                                          _onSignOut();
                                        }
                                      },
                                      elevation: 2,
                                      shape: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: AppColors.medium_2,
                                              width: 0
                                          )
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.medium_2,
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(color: AppColors.medium_1, width: 1)
                                            ),
                                            child: const Text(
                                                "MA",
                                                style: TextStyle(
                                                  color: AppColors.lightest,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                )
                                            ),
                                          ),
                                          const SizedBox(width: 4,),
                                          const Icon(
                                            Icons.arrow_drop_down,
                                            color: AppColors.light_3,
                                          )
                                        ],
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: SizedBox(
                                            width: 280,
                                            height: 60,
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.account_circle_rounded,
                                                  color: AppColors.icon,
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                    "My Account",
                                                    style: TextStyle(
                                                      color: AppColors.icon,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child: SizedBox(
                                            width: 280,
                                            height: 60,
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.settings,
                                                  color: AppColors.icon,
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                    "Settings",
                                                    style: TextStyle(
                                                      color: AppColors.icon,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                          value: 2,
                                        ),
                                        PopupMenuItem(
                                          child: SizedBox(
                                            width: 280,
                                            height: 60,
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.exit_to_app,
                                                  color: AppColors.icon,
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                    "Sign Out",
                                                    style: TextStyle(
                                                      color: AppColors.icon,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                          value: 3,
                                        ),
                                      ]
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: Utils().screenSize(context).width,
                              decoration: BoxDecorationEx.shadowEffect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(32),
                                    topLeft: Radius.circular(32),
                                  ),
                                  backgroundColor: AppColors.light_1
                              ),
                              child: widget.child,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: AppColors.dark_3.withOpacity(0.6),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.lightest,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.asset('assets/double_ring_loading_io.gif',),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
  void _onMenu() {
    _key.currentState?.openDrawer();
  }
  void _onSignOut() async {
    if (await ConfirmationDialog.showConfirmationDialog(
      context,
      content: "Are you sure you want to sign out?",
      confirmTitle: "Sign Out",
    ) == true) {
      NavigationController().notifierInitLoading.value = true;
      await AuthAPI().logout();
      NavigationController().notifierInitLoading.value = false;

      AuthStateManager().loggedIn.value = false;
    }
  }

}

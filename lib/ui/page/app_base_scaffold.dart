import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_pop_menu.dart';
import 'package:louzero/common/app_spinner.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/bindings/company_binding.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/ui/widget/appbar/app_bar_page_header.dart';
import 'package:louzero/ui/widget/side_menu/side_menu.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'company/companies.dart';

class AppBaseScaffold extends StatefulWidget {
  final Widget? child;
  final bool hasKeyboard;
  final bool logoOnly;
  final List<Widget>? footerStart;
  final List<Widget>? footerEnd;
  final String? subheader;
  const AppBaseScaffold({
    Key? key,
    this.child,
    this.footerStart,
    this.footerEnd,
    this.subheader,
    this.hasKeyboard = false,
    this.logoOnly = false,
  }) : super(key: key);

  @override
  _AppBaseScaffoldState createState() => _AppBaseScaffoldState();
}

class _AppBaseScaffoldState extends State<AppBaseScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final navigatorKey = GlobalKey<NavigatorState>();

  void _logout(BuildContext context) async {
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
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF465D66), Color(0xFF182933)],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight),
                    ),
                    child: Scaffold(
                      drawer: isLoggedIn ? const SideMenuView() : null,
                      drawerScrimColor: Colors.black.withOpacity(0),
                      key: _key,
                      resizeToAvoidBottomInset: widget.hasKeyboard,
                      // backgroundColor: AppColors.secondary_99,
                      backgroundColor: Colors.transparent,
                      drawerEnableOpenDragGesture: false,

                      appBar: widget.logoOnly
                          ? PreferredSize(
                              preferredSize: const Size.fromHeight(100.0),
                              child: AppBar(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                flexibleSpace: Center(
                                  child: Image.asset(
                                      "assets/icons/general/logo_icon.png"),
                                ),
                              ),
                            )
                          : null,

                      body: widget.logoOnly
                          ? Container(
                              color: AppColors.secondary_99,
                              child: widget.child,
                            )
                          : NestedScrollView(
                              floatHeaderSlivers: true,
                              headerSliverBuilder:
                                  (context, innerBoxIsScrolled) => [
                                AppBarPageHeader(
                                  context: context,
                                  title: SizedBox(
                                    height: 80,
                                    child: Image.asset(
                                        "assets/icons/general/logo_icon.png"),
                                  ),
                                  footerStart: [
                                    if (widget.subheader != null)
                                      Text(widget.subheader!,
                                          style: AppStyles.header_appbar),
                                    if (widget.footerStart != null)
                                      ...widget.footerStart!,
                                  ],
                                  footerEnd: widget.footerEnd,
                                  actions: [
                                    if (isLoggedIn)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: AppUserDropdownMenu(
                                          onChange: (val) {
                                            if (val == 'logout') {
                                              _logout(context);
                                            }
                                          },
                                        ),
                                      )
                                  ],
                                  onMenuPress: () {
                                    print('menu!');
                                    _key.currentState?.openDrawer();
                                  },
                                )
                              ],
                              body: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                child: Container(
                                  color: AppColors.secondary_99,
                                  child: widget.child,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      color: AppColors.secondary_95.withOpacity(0.6),
                      child: const AppSpinner(
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

class AppUserDropdownMenu extends StatelessWidget {
  final void Function(String val)? onChange;

  const AppUserDropdownMenu({Key? key, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPopMenu(
      items: [
        PopMenuItem(
          label: 'My Account',
          icon: Icons.person_rounded,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100)).then((value) =>
                Get.to(() => const CompanyListPage(),
                    binding: CompanyBinding()));
          },
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
          onTap: () {
            if (onChange != null) {
              onChange!('logout');
            }
          },
        )
      ],
      button: [
        AppAvatar(
          url: AuthManager.userModel!.avatar,
          size: 40,
          text: AuthManager.userModel!.initials,
          borderColor: AppColors.lightest,
        ),
        const Icon(Icons.arrow_drop_down, color: AppColors.lightest)
      ],
    );
  }
}

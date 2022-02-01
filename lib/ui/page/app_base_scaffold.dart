import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/bindings/company_binding.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/widget/appbar/app_bar_page_header.dart';
import 'package:louzero/ui/widget/side_menu/side_menu.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'account/account.dart';

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
  final _authController = Get.find<AuthController>();
  void _logout(BuildContext context) async {
    GetStorage().write(GSKey.isAuthUser, false);
    await AuthAPI(auth: Backendless.userService).logout();
    NavigationController().popToFirst(context);
    _authController.loggedIn.value = false;
  }

  void _toggleDrawer() {
    _key.currentState?.openDrawer();
  }

  void _menuChange(String val) {
    if (val == 'logout') {
      _logout(context);
    }
  }

  List<Widget> _getHeader() {
    return [
      if (widget.subheader != null)
        Text(widget.subheader!, style: AppStyles.headerAppBar),
      if (widget.footerStart != null) ...widget.footerStart!,
    ];
  }

  Widget _appBackground({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF465D66), Color(0xFF182933)],
            begin: Alignment.topLeft,
            end: Alignment.topRight),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: NavigationController().notifierInitLoading,
      builder: (ctx, isLoading, child) {
        return Obx(() {
          return _appBackground(
            child: Stack(
              children: [
                _backgroundDecoration(),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Scaffold(
                    key: _key,
                    drawer: _authController.loggedIn.value
                        ? const SideMenuView()
                        : null,
                    appBar: null,
                    body: widget.logoOnly
                        ? widget.child
                        : AppBaseShell(
                            footerStart: _getHeader(),
                            footerEnd: widget.footerEnd,
                            actions: [
                              if (_authController.loggedIn.value)
                                AppBaseUserMenu(onChange: _menuChange)
                            ],
                            onMenuPress: _toggleDrawer,
                            child: widget.child,
                          ),
                    drawerScrimColor: Colors.black.withOpacity(0),
                    resizeToAvoidBottomInset: widget.hasKeyboard,
                    backgroundColor: Colors.transparent,
                    drawerEnableOpenDragGesture: false,
                  ),
                ),
                if (isLoading) _spinner()
              ],
            ),
          );
        });
      },
    );
  }

  Widget _backgroundDecoration() {
    return Positioned(
      bottom: 0,
      height: MediaQuery.of(context).size.height / 1.55,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            color: AppColors.white.withOpacity(.045)),
      ),
    );
  }

  Widget _spinner() {
    return Positioned.fill(
      child: Container(
        alignment: Alignment.center,
        color: AppColors.secondary_95.withOpacity(0.6),
        child: const AppSpinner(
          size: 160,
          width: 8,
        ),
      ),
    );
  }
}

// MAIN Wrapper for all views in the app

class AppBaseShell extends StatelessWidget {
  final Widget? child;
  final bool hasKeyboard;
  final bool logoOnly;
  final bool loggedIn;
  final VoidCallback? onMenuPress;
  final List<Widget>? actions;
  final List<Widget>? footerStart;
  final List<Widget>? footerEnd;
  final String? subheader;

  const AppBaseShell(
      {Key? key,
      this.child,
      this.footerStart,
      this.footerEnd,
      this.subheader,
      this.actions,
      this.onMenuPress,
      this.hasKeyboard = false,
      this.logoOnly = false,
      this.loggedIn = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: AppBasePhysics(),
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        AppBarPageHeader(
            context: context,
            title: SizedBox(
              height: 80,
              child: Image.asset("assets/icons/general/logo_icon.png"),
            ),
            footerStart: footerStart,
            footerEnd: footerEnd,
            actions: actions,
            onMenuPress: onMenuPress)
      ],
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              minWidth: double.infinity,
            ),
            color: AppColors.secondary_99,
            // ignore: unnecessary_null_in_if_null_operators
            child: child ?? null,
          ),
        ),
      ),
    );
  }
}

// PHYSICS for NestedScrollView = removes fling and auto scroll (may need to remove on prod )

class AppBasePhysics extends ClampingScrollPhysics {
  AppBasePhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  double get minFlingVelocity => double.infinity;

  @override
  double get maxFlingVelocity => double.infinity;

  @override
  double get minFlingDistance => double.infinity;

  @override
  final SpringDescription spring =
      SpringDescription.withDampingRatio(mass: 300, stiffness: 80);

  @override
  AppBasePhysics applyTo(ScrollPhysics? ancestor) {
    return AppBasePhysics(parent: buildParent(ancestor)!);
  }
}

// LOGGED IN USER MENU (IN PROGRESS)

class AppBaseUserMenu extends StatelessWidget {
  final void Function(String val)? onChange;

  const AppBaseUserMenu({Key? key, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 0, right: 8, bottom: 0),
      child: AppPopMenu(
        items: [
          PopMenuItem(
            label: 'My Account',
            icon: Icons.person_rounded,
            onTap: () {
              Future.delayed(const Duration(milliseconds: 100)).then((value) =>
                  Get.to(() => const MyAccountPage(),
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
            url: Get.find<AuthController>().user.avatar,
            size: 40,
            text: Get.find<AuthController>().user.initials,
            borderColor: AppColors.lightest,
          ),
          const Icon(Icons.arrow_drop_down, color: AppColors.lightest)
        ],
      ),
    );
  }
}

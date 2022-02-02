import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/account/account_setup.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/auth_layout.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';

class CompletePage extends StatefulWidget {
  final String email;
  const CompletePage(this.email, {Key? key}) : super(key: key);

  @override
  _CompletePageState createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  final _authController = Get.find<AuthController>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailSelected = false;
  bool _termsSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var optInEmail =
        'Yes, I would like to receive email updates about products & services, upcoming webinars, news and events from LOUzero.';
    var termsLabel = 'I have read and agreed to the Terms of Service';
    return AppBaseScaffold(
      logoOnly: true,
      child: AuthLayout(
        children: [
          AppCard(
            maxWidth: 512,
            px: 48,
            py: 48,
            children: [
              const Text('Complete Signup', style: AppStyles.headerLarge),
              const SizedBox(height: 8),
              const Text(
                  'Fill in your information below to finish the signup process.',
                  style: AppStyles.labelRegular),
              const SizedBox(height: 32),
              AppTextField(
                controller: _firstNameController,
                label: 'First Name',
                keyboardType: TextInputType.name,
              ),
              AppTextField(
                controller: _lastNameController,
                label: 'Last Name',
                keyboardType: TextInputType.name,
              ),
              AppTextField(
                controller: _passwordController,
                label: 'Password (8 or more characters)',
                password: true,
              ),
              const SizedBox(height: 32),
              AppCheckbox(
                mb: 15,
                label: termsLabel,
                checked: _termsSelected,
                onChanged: (val) {
                  setState(() {
                    _termsSelected = val!;
                  });
                },
              ),
              AppCheckbox(
                label: optInEmail,
                checked: _emailSelected,
                onChanged: (val) {
                  setState(() {
                    _emailSelected = val!;
                  });
                },
              ),
              const SizedBox(height: 24),
              Buttons.loginPrimary(
                'Create Account',
                onPressed: _completeSignup,
                expanded: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _completeSignup() async {
    NavigationController().loading();
    var res = await AuthAPI(auth: Backendless.userService)
        .signup(widget.email, _passwordController.text);
    if (res is String) {
      NavigationController().loading(isLoading: false);
      WarningMessageDialog.showDialog(context, res);
    } else {
      if (_authController.guestUserId != null) {
        await AuthAPI(auth: Backendless.userService).cleanupGuestUser();
      }
      NavigationController().loading(isLoading: false);
      Get.find<AuthController>().loggedIn.value = true;
      _authController.user.firstname = _firstNameController.text;
      _authController.user.lastname = _lastNameController.text;
      await Get.find<AuthController>().updateUser();
      Get.to(() => const AccountSetup());
    }
  }
}

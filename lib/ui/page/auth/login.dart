import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/validators.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/accept_invite.dart';
import 'package:louzero/ui/page/auth/reset_password.dart';
import 'package:louzero/ui/page/auth/signup.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // if (kDebugMode) {
    //   _emailController.text = "josh.webdev@gmail.com";
    //   _passwordController.text = "!1QAwsEDrf";
    // }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      logoOnly: true,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset("assets/icons/general/logo_icon.png"),
          const SizedBox(
            height: 56,
          ),
          SizedBox(
            width: 512,
            child: Form(
              key: formGlobalKey,
              child: AppTabsBasic(
                contentHeight: 490,
                children: [_loginForm(), _createAccount()],
                tabs: const [
                  'Login',
                  'Create Account',
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            child: Text("HAVE AN INVITATION CODE?",
                style:
                    AppStyles.labelBold.copyWith(color: AppColors.primary_70)),
            onTap: () => Get.to(() => const AcceptInvitePage()),
          ),
          Expanded(
              child: Flex(
            mainAxisAlignment: MainAxisAlignment.end,
            direction: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppTextLink(
                    'Accept Invite',
                    onPressed: _onAcceptInvite,
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _createAccount() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 48, right: 48),
      child: Column(
        children: [
          Buttons.loginOutline('Sign In with Google',
              onPressed: _onGoogleSignIn),
          const AppTextDivider(),
          AppTextField(
            required: true,
            key: const ValueKey('Email Create Account'),
            controller: _emailController,
            label: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val != null && val.isEmpty) {
                return 'Email is required';
              }
              if (Valid.email(val!)) {
                return null;
              } else {
                return 'Enter Valid Email';
              }
            },
          ),
          const SizedBox(
            height: 22,
          ),
          Buttons.loginPrimary('Sign In', onPressed: _onSignIn),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 48, right: 48),
      child: Column(
        children: [
          AppTextField(
            required: true,
            key: const ValueKey('Email Address'),
            controller: _emailController,
            label: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val != null && val.isEmpty) {
                return 'Email is required';
              }
              if (Valid.email(val!)) {
                return null;
              } else {
                return 'Enter Valid Email';
              }
            },
          ),
          AppTextField(
            password: true,
            key: const ValueKey('Password'),
            controller: _passwordController,
            label: 'Password',
            validator: (val) {
              if (Valid.isRequired(val)) {
                return 'Password is required';
              }
              if (Valid.password(val!)) {
                return null;
              } else {
                return 'Password must be at least six characters';
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextLink(
                "Remember this device",
                onPressed: _onRememberDevice,
              ),
              AppTextLink(
                "Forgot Password?",
                fontWeight: FontWeight.w600,
                textDecoration: TextDecoration.underline,
                onPressed: _onResetPassword,
              ),
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          Buttons.loginPrimary(
            'Sign In',
            onPressed: _onSignIn,
          ),
          const AppTextDivider(),
          Buttons.loginOutline(
            'Sign In with Google',
            onPressed: _onGoogleSignIn,
          ),
        ],
      ),
    );
  }

  void _onCreateAccount() {
    Get.to(() => const SignUpPage());
  }

  void _onAcceptInvite() {
    Get.to(() => const AcceptInvitePage());
  }

  void _onSignIn() async {
    if (formGlobalKey.currentState!.validate()) {
      NavigationController().loading();
      var res = await AuthAPI(auth: Backendless.userService)
          .login(_emailController.text, _passwordController.text);
      NavigationController().loading(isLoading: false);
      if (res is String) {
        WarningMessageDialog.showDialog(context, res);
      } else {
        Get.find<AuthController>().loggedIn.value = true;
      }
    }
  }

  void _onRememberDevice() {}
  void _onResetPassword() {
    Get.to(() => const ResetPasswordPage());
  }

  void _onGoogleSignIn() {}
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_divider.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_text_help_link.dart';
import 'package:louzero/common/app_text_link.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/ui/page/auth/reset_password.dart';
import 'package:louzero/ui/page/auth/signup.dart';
import 'package:louzero/ui/page/auth/verify.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/dialolg/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    if (kDebugMode) {
      _emailController.text = "mark.austen@singlemindconsulting.com";
      _passwordController.text = "73SWhjN3";
    }
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
    return BaseScaffold(
      child: Column(
        children: [
          const SizedBox(
            height: 128,
          ),
          AppCardCenter(
            child: Column(
              children: [
                const AppTextHeader('Sign in to LOUzero'),
                AppTextHelpLink(
                  label: 'New to LOUzero? ',
                  linkText: 'Create an Account',
                  onPressed: _onCreateAccount,
                ),
                AppInputText(
                  mt: 40,
                  controller: _emailController,
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                AppInputText(
                  controller: _passwordController,
                  label: 'Password',
                  password: true,
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
                AppButton(
                    onPressed: _onSignIn, label: 'Sign In', icon: Icons.lock),
                const AppTextDivider(),
                AppButton(
                  onPressed: _onGoogleSignIn,
                  label: 'Sign In with Google',
                  primary: false,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          AppTextLink(
            "HAVE AN INVITATION CODE?",
            fontWeight: FontWeight.w700,
            onPressed: _verificationCode,
          ),
        ],
      ),
    );
  }

  void _onCreateAccount() {
    NavigationController().pushTo(context, child: const SignUpPage());
  }

  void _onSignIn() async {
    NavigationController().notifierInitLoading.value = true;
    var res =
        await AuthAPI().login(_emailController.text, _passwordController.text);
    NavigationController().notifierInitLoading.value = false;
    if (res is String) {
      WarningMessageDialog.showDialog(context, res);
    } else {
      AuthStateManager().loggedIn.value = true;
    }
  }

  void _onRememberDevice() {}
  void _onResetPassword() {
    NavigationController().pushTo(context, child: const ResetPasswordPage());
  }

  void _verificationCode() {
    NavigationController().pushTo(context, child: const VerifyPage());
  }

  void _onGoogleSignIn() {}
}

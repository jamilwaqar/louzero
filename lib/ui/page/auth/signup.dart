import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_divider.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_text_help_link.dart';
import 'package:louzero/common/app_text_link.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/verify.dart';
import 'package:louzero/ui/widget/dialolg/warning_dialog.dart';
import 'accept_invite.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    if (kDebugMode) {
      _emailController.text = "mark.austen@singlemindconsulting.com";
      _passwordController.text = "louzerouser_123";
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
    return AppBaseScaffold(
      logoOnly: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppCardCenter(
            child: Column(
              children: [
                const AppTextHeader('Create Account'),
                AppTextHelpLink(
                    label: 'Already using LOUzero? ',
                    linkText: 'Sign In here',
                    onPressed: _onSignIn),
                const SizedBox(
                  height: 22,
                ),
                AppButton(
                  label: 'Sign Up with Google',
                  onPressed: _onGoogleSignUp,
                  primary: false,
                ),
                const AppTextDivider(),
                const AppTextBody('Enter your email to create a new account '),
                AppInputText(
                  mt: 16,
                  controller: _emailController,
                  label: 'Your Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                // AppInputText(
                //   mb: 32,
                //   controller: _passwordController,
                //   label: 'Your Password',
                //   password: true,
                // ),
                AppButton(
                  label: 'Continue',
                  // icon: Icons.lock,
                  onPressed: _onSendVerificationCode,
                ),
              ],
            ),
          ),
          AppTextLink(
            "HAVE AN INVITATION CODE?",
            fontWeight: FontWeight.w700,
            textDecoration: TextDecoration.underline,
            onPressed: () {
              Get.to(() => const AcceptInvitePage());
            },
          ),
        ],
      ),
    );
  }

  void _onSignIn() {
    NavigationController().pop(context);
  }

  void _onSendVerificationCode() async {
    NavigationController().loading();
    var code = verificationCode();
    var email = _emailController.text;
    var res = await AuthAPI(auth: Backendless.userService)
        .sendVerificationCode(email, code);
    await Future.delayed(const Duration(seconds: 1));
    NavigationController().loading(isLoading: false);
    if (res is String) {
      WarningMessageDialog.showDialog(context, res);
    } else {
      Get.to(() => VerifyPage(email: email, code: code));
    }
  }

  void _onGoogleSignUp() {}
}

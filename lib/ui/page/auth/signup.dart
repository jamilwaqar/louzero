import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_text_divider.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_text_help_link.dart';
import 'package:louzero/common/app_text_link.dart';
import 'package:louzero/common/app_textfield.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/validators.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/verify.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';
import 'accept_invite.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (kDebugMode) {
      // _emailController.text = "mark.austen@singlemindconsulting.com";
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
            child: Form(
              key: formGlobalKey,
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
                  Buttons.outline('Sign Up with Google',
                      onPressed: _onGoogleSignUp, expanded: true),
                  const AppTextDivider(),
                  const Text(
                    'Enter your email to create a new account ',
                    style: AppStyles.labelBold,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return 'Email is required';
                      }
                      if (Valid.Email(val!)) {
                        return null;
                      } else {
                        return 'Enter Valid Email';
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Buttons.primary('Continue', expanded: true, onPressed: () {
                    if (formGlobalKey.currentState!.validate()) {
                      _onSendVerificationCode();
                    }
                  })
                ],
              ),
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

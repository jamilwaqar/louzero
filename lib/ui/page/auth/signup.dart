import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/validators.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/auth/verify.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (kDebugMode) {
      // _emailController.text = "mark.austen@singlemindconsulting.com";
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 48,
          right: 48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const AppTextFieldLabel(
                'Enter your email to create a new account.'),
            AppTextField(
              key: const ValueKey('Email Address'),
              controller: _emailController,
              label: 'Email',
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
            const Spacer(),
            const SizedBox(height: 22),
            Buttons.loginPrimary('Create Account', expanded: true,
                onPressed: () {
              if (formGlobalKey.currentState!.validate()) {
                _onSendVerificationCode();
              }
            }),
            const AppTextDivider(),
            Buttons.loginOutline(
              'Sign In with Google',
              icon: MdiIcons.google,
              onPressed: () {},
            ),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
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
}

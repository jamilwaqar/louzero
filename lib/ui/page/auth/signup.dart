import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/validators.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUpPage extends GetWidget<AuthController> {
  SignUpPage({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

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
                controller.sendVerification(email: _emailController.text, code: verificationCode());
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/auth_layout.dart';

class CompleteSignupPage extends GetWidget<AuthController> {
  final String email;
  CompleteSignupPage(this.email, {Key? key}) : super(key: key);

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailSelected = false.obs;
  final _termsSelected = false.obs;

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
              Obx(()=> AppCheckbox(
                mb: 15,
                label: termsLabel,
                checked: _termsSelected.value,
                onChanged: (val) {
                  _termsSelected.value = val!;
                },
              ),),
              Obx(()=> AppCheckbox(
                label: optInEmail,
                checked: _emailSelected.value,
                onChanged: (val) {
                   _emailSelected.value = val!;
                },
              ),),
              const SizedBox(height: 24),
              Buttons.loginPrimary(
                'Create Account',
                onPressed: () {
                  //TODO: Add validation for password, names fields.

                  controller.signUp(
                      email: email,
                      password: _passwordController.text,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text);
                },
                expanded: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

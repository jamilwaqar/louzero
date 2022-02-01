import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/validators.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/auth_layout.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
    const title = "Trouble logging in?";
    const body =
        "Not to worry. Enter the email address you use to sign in to LOUzero below and we'll send you instructions on how to set a new password.";
    return AppBaseScaffold(
      logoOnly: true,
      child: AuthLayout(
        children: [
          AppCard(
            px: 48,
            py: 48,
            maxWidth: 512,
            children: [
              Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      title,
                      style: AppStyles.headerLarge,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      body,
                      style: AppStyles.labelRegular.copyWith(height: 1.5),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    AppTextField(
                      controller: _emailController,
                      key: const Key('Email Address'),
                      label: "Email",
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
                    SizedBox(
                      height: 24,
                    ),
                    Buttons.loginPrimary(
                      'Email Reset Instructions',
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          _onResetPassword();
                        }
                      },
                      expanded: true,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    AppTextHelpLink(
                        ml: 8,
                        mt: 16,
                        center: false,
                        label: 'Go back to the ',
                        linkText: 'Sign In',
                        trailingText: 'screen',
                        onPressed: _onSignIn),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onResetPassword() async {
    NavigationController().loading();
    await AuthAPI(auth: Backendless.userService)
        .resetPassword(_emailController.text);
    NavigationController().loading(isLoading: false);
    NavigationController().pop(context);
  }

  void _onSignIn() async {
    NavigationController().pop(context);
  }
}

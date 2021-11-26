import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_divider.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_text_help_link.dart';
import 'package:louzero/common/app_text_link.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/ui/page/auth/verify.dart';
import 'package:louzero/ui/widget/dialolg/warning_dialog.dart';
import '../base_scaffold.dart';

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
    return BaseScaffold(
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
                AppInputText(
                  mb: 32,
                  controller: _passwordController,
                  label: 'Your Password',
                  password: true,
                ),
                AppButton(
                  label: 'Create Account',
                  // icon: Icons.lock,
                  onPressed: _onCreateAccount,
                ),
              ],
            ),
          ),
          AppTextLink(
            "HAVE AN INVITATION CODE?",
            fontWeight: FontWeight.w700,
            textDecoration: TextDecoration.underline,
            onPressed: () {
              NavigationController().pushTo(context, child: const VerifyPage());
            },
          ),
        ],
      ),
    );
  }

  void _onSignIn() {
    NavigationController().pop(context);
  }

  void _onCreateAccount() async {
    NavigationController().loading();
    var res =
        await AuthAPI().signup(_emailController.text, _passwordController.text);
    NavigationController().loading(isLoading: false);

    if (res is String) {
      WarningMessageDialog.showDialog(context, res);
    } else {
      AuthStateManager().loggedIn.value = true;
    }
  }

  void _onGoogleSignUp() {}
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/decoration.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/ui/page/auth/reset_password.dart';
import 'package:louzero/ui/page/auth/signup.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';
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
          const SizedBox(height: 128,),
          Container(
            width: 496,
            padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
            decoration: BoxDecorationEx.shadowEffect(
                borderRadius: BorderRadius.circular(16),
                blurRadius: 3,
                shadowOffset: const Offset(0, 1),
                shadowRadius: 2,
                backgroundColor: AppColors.lightest
            ),
            child: Column(
              children: [
                const Text(
                  "Sign in to LOUzero",
                  style: TextStyle(
                    color: AppColors.dark_1,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New to LOUzero? ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark_1,
                      ),
                    ),
                    LZTextButton(
                      "Create an Account",
                      fontWeight: FontWeight.w700,
                      textDecoration: TextDecoration.underline,
                      onPressed: _onCreateAccount,
                    ),
                  ],
                ),
                const SizedBox(height: 14,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email Address",
                      style: TextStyle(
                        color: AppColors.dark_1,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      height: 48,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.light_3, width: 1)
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardAppearance: Brightness.light,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                        ),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.dark_3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Password",
                      style: TextStyle(
                        color: AppColors.dark_1,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      height: 48,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.light_3, width: 1)
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardAppearance: Brightness.light,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.dark_3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LZTextButton(
                      "Remember this device",
                      onPressed: _onRememberDevice,
                    ),
                    LZTextButton(
                      "Forgot Password?",
                      fontWeight: FontWeight.w700,
                      textDecoration: TextDecoration.underline,
                      onPressed: _onResetPassword,
                    ),
                  ],
                ),
                const SizedBox(height: 22,),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _onSignIn,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.dark_1,
                        borderRadius: BorderRadius.circular(28)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.lock,
                          color: AppColors.light_2,
                        ),
                        SizedBox(width: 8,),
                        Text(
                            "Sign In",
                            style: TextStyle(
                              color: AppColors.lightest,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.light_3,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                          "or",
                          style: TextStyle(
                            color: AppColors.dark_1,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.light_3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _onGoogleSignIn,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.light_1,
                        borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.medium_1, width: 1)
                    ),
                    child: const Text(
                        "Sign In with Google",
                        style: TextStyle(
                          color: AppColors.dark_1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          LZTextButton(
            "HAVE AN INVITATION CODE?",
            fontWeight: FontWeight.w700,
            textDecoration: TextDecoration.underline,
            onPressed: () {},
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
    var res = await AuthAPI().login(_emailController.text, _passwordController.text);
    NavigationController().notifierInitLoading.value = false;
    if (res is String) {
      WarningMessageDialog.showDialog(context, res);
    } else {
      AuthStateManager().loggedIn.value = true;
    }
  }
  void _onRememberDevice() {

  }
  void _onResetPassword() {
    NavigationController().pushTo(context, child: const ResetPasswordPage());
  }
  void _onGoogleSignIn() {

  }
}

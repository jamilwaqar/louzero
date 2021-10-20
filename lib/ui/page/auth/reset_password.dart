import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/decoration.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';

import '../base_scaffold.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    if (kDebugMode) {
      _emailController.text = "mark.austen@singlemindconsulting.com";
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
    return BaseScaffold(
      child: Column(
        children: [
          const SizedBox(height: 128,),
          Container(
            width: 496,
            padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
            decoration: BoxDecorationEx.shadowEffect(
                borderRadius: 16,
                blurRadius: 3,
                shadowOffset: const Offset(0, 1),
                shadowRadius: 2,
                backgroundColor: AppColors.lightest
            ),
            child: Column(
              children: [
                Text(
                  "Can't Log in?",
                  style: TextStyle(
                    color: AppColors.dark_1,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Not to worry. Enter the email address you use to sign in to LOUzero below and we'll send you instructions on how to set a new password. ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.dark_1,
                    ),
                  ),
                ),
                const SizedBox(height: 32,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Email",
                      style: TextStyle(
                        color: AppColors.dark_1,
                        fontWeight: FontWeight.w700,
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.dark_3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32,),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _onResetPassword,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.dark_1,
                        borderRadius: BorderRadius.circular(28)
                    ),
                    child: Text(
                        "Email Reset Instructions",
                        style: TextStyle(
                          color: AppColors.lightest,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 14,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Never mind, go back to the ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark_1,
                      ),
                    ),
                    LZTextButton(
                      "Sign in",
                      fontWeight: FontWeight.w700,
                      textDecoration: TextDecoration.underline,
                      onPressed: _onSignIn,
                    ),
                    Text(
                      ' screen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark_1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _onResetPassword() async {
    NavigationController().notifierInitLoading.value = true;
    await AuthAPI().resetPassword(_emailController.text);
    NavigationController().notifierInitLoading.value = false;
    NavigationController().pop(context);
  }
  void _onSignIn() async {
    NavigationController().pop(context);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/decoration.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';

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
                  "Create Account",
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
                    Text(
                      'Already using LOUzero? ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark_1,
                      ),
                    ),
                    LZTextButton(
                      "Sign In here",
                      fontWeight: FontWeight.w700,
                      textDecoration: TextDecoration.underline,
                      onPressed: _onSignIn,
                    ),
                  ],
                ),
                const SizedBox(height: 22,),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _onGoogleSignUp,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.light_1,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.medium_1, width: 1)
                    ),
                    child: Text(
                        "Sign up with Google",
                        style: TextStyle(
                          color: AppColors.dark_1,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        )
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter your email to create a new account",
                      style: TextStyle(
                        color: AppColors.dark_1,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16,),
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
                const SizedBox(height: 24,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
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
                        controller: _passwordController,
                        keyboardAppearance: Brightness.light,
                        obscureText: true,
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
                  onPressed: _onCreateAccount,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.dark_1,
                        borderRadius: BorderRadius.circular(28)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: AppColors.light_2,
                        ),
                        const SizedBox(width: 8,),
                        Text(
                            "Create Account",
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

  void _onSignIn() {
    NavigationController().pop(context);
  }
  void _onCreateAccount() async {
    NavigationController().notifierInitLoading.value = true;
    var res = await AuthAPI().signup(_emailController.text, _passwordController.text);
    NavigationController().notifierInitLoading.value = false;
    print(res);
  }
  void _onGoogleSignUp() {

  }
}

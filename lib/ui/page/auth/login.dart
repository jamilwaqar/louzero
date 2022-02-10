import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/validators.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/accept_invite.dart';
import 'package:louzero/ui/page/auth/auth_layout.dart';
import 'package:louzero/ui/page/auth/reset_password.dart';
import 'package:louzero/ui/page/auth/signup.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool _rememberDevice = false;

  @override
  void initState() {
    _emailController.text = "josh.webdev@gmail.com";
    _passwordController.text = "!1QAwsEDrf";
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
      child: AuthLayout(
        children: [
          SizedBox(
            width: 512,
            child: Form(
              key: formGlobalKey,
              child: AppTabsBasic(
                contentHeight: 490,
                children: [_loginForm(), SignUpPage()],
                tabs: const [
                  'Sign In',
                  'Create Account',
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            child: Text("HAVE AN INVITATION CODE?",
                style:
                    AppStyles.labelBold.copyWith(color: AppColors.primary_70)),
            onTap: () => Get.to(() => const AcceptInvitePage()),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 48, right: 48),
      child: Column(
        children: [
          AppTextField(
            required: true,
            key: const ValueKey('Email Address'),
            controller: _emailController,
            label: 'Email Address',
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
          AppTextField(
            password: true,
            key: const ValueKey('Password'),
            controller: _passwordController,
            label: 'Password',
            validator: (val) {
              if (Valid.isRequired(val)) {
                return 'Password is required';
              }
              if (Valid.password(val!)) {
                return null;
              } else {
                return 'Password must be at least six characters';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          FlexRow(
            flex: const [1, 0],
            children: [
              AppCheckbox(
                label: 'Remember this device',
                checked: _rememberDevice,
                onChanged: (val) {
                  _onRememberDevice();
                },
              ),
              GestureDetector(
                onTap: _onResetPassword,
                child: Text("Forgot Password?",
                    style: AppStyles.labelBold
                        .copyWith(color: AppColors.primary_50)),
              )
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          Buttons.loginPrimary(
            'Sign In',
            onPressed: _onSignIn,
          ),
          const AppTextDivider(),
          Buttons.loginOutline(
            'Sign In with Google',
            onPressed: _onGoogleSignIn,
          ),
        ],
      ),
    );
  }

  void _onSignIn() async {
    if (formGlobalKey.currentState!.validate()) {
      NavigationController().loading();
      var res = await AuthAPI(auth: Backendless.userService)
          .login(_emailController.text, _passwordController.text);
      NavigationController().loading(isLoading: false);
      if (res is String) {
        WarningMessageDialog.showDialog(context, res);
      } else {
        Get.find<AuthController>().loggedIn.value = true;
      }
    }
  }

  void _onRememberDevice() {
    setState(() {
      _rememberDevice = !_rememberDevice;
    });
  }

  void _onResetPassword() {
    Get.to(() => const ResetPasswordPage());
  }

  void _onGoogleSignIn() {}
}

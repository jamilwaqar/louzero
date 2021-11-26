import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_text_help_link.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/auth/complete.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/common/app_button.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool _onEditing = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final styleText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.dark_1,
  );
  final styleTextBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.darkest,
  );
  final styleTextHeading = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.darkest,
  );

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
  build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppCardCenter(
            child: Column(
              children: [
                const AppTextHeader('Verification Code'),
                const AppTextBody('We sent a verification code to'),
                const AppTextBody(
                  'josh.coolman@singlemindconsulting.com',
                  color: AppColors.dark_3,
                  bold: true,
                ),
                const AppTextBody('Enter that code to continue',
                    mt: 24, mb: 16),
                VerificationCode(
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkest,
                  ),
                  keyboardType: TextInputType.number,
                  underlineColor: AppColors.darkest,
                  fillColor: AppColors.darkest,
                  // itemSize: 60,
                  length: 6,
                  onCompleted: (String value) {
                    setState(() {
                      // _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 40),
                AppButton(
                  label: 'Continue',
                  onPressed: _completeSignup,
                  wide: true,
                ),
              ],
            ),
          ),
          AppTextHelpLink(
            label: 'Haven\'t received your code yet? ',
            linkText: 'Resend Code',
            onPressed: _methodTBD,
          ),
          AppTextHelpLink(
            label: 'Go back to ',
            linkText: 'Login',
            onPressed: _goback,
          ),
        ],
      ),
    );
  }

  void _goback() async {
    NavigationController().pop(context);
  }

  void _completeSignup() {
    NavigationController().pushTo(context, child: const CompletePage());
  }

  void _methodTBD() {}
}
